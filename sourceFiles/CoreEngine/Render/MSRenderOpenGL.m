//
//  MSRenderOpenGL.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 28/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSRenderOpenGL.h"

@implementation MSRenderOpenGL
-(instancetype)initWithWorld:(MSWorld *)w modelShader: (GLuint)mSh lightShader: (GLuint)lsh{
    self=[super init];
    if(self){
        self->world=w;
        self->modelsLoadedToGraphics = [[NSMutableDictionary alloc] init];
        self->lightShaderProgram=lsh;
        self->modelShaderProgram=mSh;
        [self loadObjectsToGraphics];
        [self setUpOpenGLOptions];
    }
    return self;
}
-(void)setUpOpenGLOptions{
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LEQUAL);
}
-(void)loadObjectsToGraphics{
    for(MSPuppet* model in [world getModels]){
        for(MSModelFraction* frac in [model getModelComponents]){
            MSDrawableFraction* drawableFraction = [[MSDrawableFraction alloc] initWithFraction:frac];
            [modelsLoadedToGraphics setObject:drawableFraction forKey:[frac getUniqueName]];
            [self setShaderFeeding:drawableFraction program:modelShaderProgram];
        }
    }
}
-(void)setShaderFeeding: (MSDrawableFraction*) fraction program: (GLuint)shaderProgram{
    glBindVertexArray([fraction vao]);
    //vertices data
    glBindBuffer(GL_ARRAY_BUFFER, [fraction verticesBuffer]);
    glVertexAttribPointer(glGetAttribLocation(shaderProgram, "position"), 3, GL_FLOAT, GL_FALSE, 3*sizeof(float), 0);
    glEnableVertexAttribArray(glGetAttribLocation(shaderProgram, "position"));
    //normals data
    glBindBuffer(GL_ARRAY_BUFFER, [fraction normalsBuffer]);
    glVertexAttribPointer(glGetAttribLocation(shaderProgram, "normal"), 3, GL_FLOAT, GL_FALSE, 3*sizeof(float), 0);
    glEnableVertexAttribArray(glGetAttribLocation(shaderProgram, "normal"));
#if macOS
    glBindFragDataLocation(shaderProgram, 0, "outColor");
#endif
    glBindVertexArray(0);
}
-(void)setBehavioureforeEachDraw: (void (^_Nullable)(void))block{
    self->_beforeDrawAction=block;
}
-(void)drawScene{
    [self clear];
    [self drawModels];
}
-(void)setUpUniforms: (MSModelFraction*) frac shaderProgram: (GLuint) prog{
        if([frac material] != nil){
            MSVector4D* diffuse = [[frac material] diffuse];
            MSVector4D* ambient = [[frac material] ambient];
            float shininess = [[frac material] shininess];
            glUniform3fv(glGetUniformLocation(prog, "diffuseColor"), 1, [diffuse getArrayStyleVector]);
            glUniform3fv(glGetUniformLocation(prog, "ambientColor"), 1, [ambient getArrayStyleVector]);
            glUniform1f(glGetUniformLocation(prog, "shininess"), shininess);
        }else{
            glUniform3fv(glGetUniformLocation(prog, "diffuseColor"), 1, [[MSVectorND onesVector:3] getArrayStyleVector]);
            glUniform3fv(glGetUniformLocation(prog, "ambientColor"), 1, [[MSVectorND onesVector:3] getArrayStyleVector]);
            glUniform1f(glGetUniformLocation(prog, "shininess"), 1.0f);
        }
}
-(void)drawModels{
    glUseProgram(modelShaderProgram);
    for(MSPuppet* puppet in [world getModels]){
            glUniform3fv(glGetUniformLocation(modelShaderProgram, "lightColor"), 1, [[[[world getLightSources]objectAtIndex:0] color]getArrayStyleVector]);
            glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "lightPosition"), 1, GL_FALSE, [[[[world getLightSources]objectAtIndex:0]getTranslation]matrixAsArray]);
        id<MSPositionedObject> cam = [world getCamera];
            glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "cameraTranslation.camTr"), 1, GL_FALSE, [[cam getTranslation] matrixAsArray]);
            glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "cameraRotation"), 1, GL_FALSE, [[cam getRotation] matrixAsArray]);
        MSMatrixND* perspectiveMatrix = [MSTransformationManager perpsectiveWithFoV:120 aspectRatio:16.0f/9.0f near:0.1 far:1000];
        glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "rotation"), 1, GL_FALSE,  [[puppet getRotation] matrixAsArray]);
        glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "translation"), 1, GL_FALSE,  [[puppet getTranslation] matrixAsArray]);
        glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "scale"), 1, GL_FALSE, [[puppet getScale] matrixAsArray]);
        glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "projection"), 1, GL_FALSE, [perspectiveMatrix matrixAsArray]);
        
        
        for(MSModelFraction* fraction in [puppet getModelComponents]){
            [self setUpUniforms:fraction shaderProgram:modelShaderProgram];
            glUniform3fv(glGetUniformLocation(modelShaderProgram, "specularColor"), 1, [[[fraction material] specular] getArrayStyleVector]);

            MSDrawableFraction* modelToDraw = [modelsLoadedToGraphics objectForKey:[fraction getUniqueName]];
                glBindVertexArray([modelToDraw vao]);
                NSLog(@"%i", [modelToDraw trianglesToDraw]);
                glDrawArraysInstanced(GL_TRIANGLES, 0, (GLsizei)([modelToDraw trianglesToDraw]), 1);
                glBindVertexArray(0);
        }
    }
    glUseProgram(0);
}
-(void)clear{
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    glClearColor(1.0f, 1.0f, 0.0f, 1.0f);
}
-(void)setBehaviourAfterEachDraw: (void (^_Nullable)(void))block{
    self->_afterDrawAction=block;
}

@end
