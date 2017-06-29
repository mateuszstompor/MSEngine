//
//  MSRenderOpenGL.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 28/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSRenderOpenGL.h"

@implementation MSRenderOpenGL

@synthesize settings;

-(instancetype)initWithWorld:(MSWorld *)w modelShader: (GLuint)mSh lightShader: (GLuint)lsh{
    self=[super init];
    if(self){
        self->world=w;
        self->modelsLoadedToGraphics = [[NSMutableDictionary alloc] init];
        self->lightShaderProgram=lsh;
        self->modelShaderProgram=mSh;
        self->amountOfFramesRendered=0;
        self->settings=0;
        self->lastSecond=[NSDate date];
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
    [self printFPSOnConsole:false];
    [self clear];
    [self drawModels];
}
-(void)printFPSOnConsole: (BOOL) printOnConsole{
    NSDate *now = [NSDate date];
    NSTimeInterval executionTime = [now timeIntervalSinceDate:lastSecond];
    if(executionTime > 1.0f && printOnConsole == true){
        NSLog(@"%f", amountOfFramesRendered/executionTime);
        amountOfFramesRendered=0;
        lastSecond=[NSDate date];
    }
    amountOfFramesRendered+=1;
}
-(void)setUpUniforms: (MSModelFraction*) frac shaderProgram: (GLuint) prog{
        glUniform1i(glGetUniformLocation(prog, "settings"), self->settings);
        if([frac material] != nil){
            MSVector3D* diffuse = [[frac material] diffuse];
            MSVector3D* ambient = [[frac material] ambient];
            MSVector3D* specular = [[frac material] specular];
            float shininess = [[frac material] shininess];
            glUniform3fv(glGetUniformLocation(prog, "specularColor"), 1, [specular getArrayStyleVector]);
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
    MSCamera* cam = [world getCamera];

    glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "camera.projection"), 1, GL_FALSE, [[cam getProjectionMatrix] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "camera.translation"), 1, GL_FALSE, [[cam translation] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "camera.rotation"), 1, GL_FALSE, [[cam rotation] matrixAsArray]);
    
    
    
    for(MSPuppet* puppet in [world getModels]){
            glUniform3fv(glGetUniformLocation(modelShaderProgram, "lightColor"), 1, [[[[world getLightSources]objectAtIndex:0] color]getArrayStyleVector]);
            glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "lightPosition"), 1, GL_FALSE, [[[[world getLightSources]objectAtIndex:0]translation]matrixAsArray]);
        
        
        glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "transformation.rotation"), 1, GL_FALSE,  [[puppet rotation] matrixAsArray]);
        glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "transformation.translation"), 1, GL_FALSE,  [[puppet translation] matrixAsArray]);
        glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, "transformation.scale"), 1, GL_FALSE, [[puppet scale] matrixAsArray]);
        
        
        for(MSModelFraction* fraction in [puppet getModelComponents]){
            [self setUpUniforms:fraction shaderProgram:modelShaderProgram];

            MSDrawableFraction* modelToDraw = [modelsLoadedToGraphics objectForKey:[fraction getUniqueName]];
                glBindVertexArray([modelToDraw vao]);
                glDrawArraysInstanced(GL_TRIANGLES, 0, (GLsizei)([modelToDraw trianglesToDraw]), 1);
                glBindVertexArray(0);
        }
    }
    glUseProgram(0);
}
-(void)clear{
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
}
-(void)setBehaviourAfterEachDraw: (void (^_Nullable)(void))block{
    self->_afterDrawAction=block;
}
-(void)setSettings: (int) set{
    self->settings=set;
}
-(void)dealloc{
    glDeleteProgram(modelShaderProgram);
    glDeleteProgram(lightShaderProgram);
}
@end
