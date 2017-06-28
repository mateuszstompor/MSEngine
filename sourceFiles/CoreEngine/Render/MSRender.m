//
//  MSRender.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSRender.h"



@implementation MSRender
-(void)drawObject: (MSPuppet*)model withProgram: (GLuint)shProg{
    for(MSModelFraction* frac in [model getModelComponents]){
        [self drawFraction:frac model:model program:shProg];
        
    }
}
-(void)drawFraction:(MSModelFraction*)frac model:(MSPuppet*)md program: (GLuint)shProg{
    glUseProgram(shProg);
    glBindVertexArray([frac getVerticiesVAO]);
    glBindBuffer(GL_ARRAY_BUFFER, [frac getBuffer]);
    glUniform1i(glGetUniformLocation(shProg, "settings"), self->settings);
    glVertexAttribPointer(glGetAttribLocation(shProg, "position"), 3, GL_FLOAT, GL_FALSE, 6*sizeof(GLfloat), 0);
    glEnableVertexAttribArray(glGetAttribLocation(shProg, "position"));
    glVertexAttribPointer(glGetAttribLocation(shProg, "normal"), 3, GL_FLOAT, GL_FALSE, 6*sizeof(GLfloat), (void*)(3*sizeof(GLfloat)));
    glEnableVertexAttribArray(glGetAttribLocation(shProg, "normal"));
#if macOS
    glBindFragDataLocation(shProg, 0, "outColor");
#endif
    [self loadTransformationFromModelToShader: md shaderProgram:shProg];
    [self updateCameraPositionInShader: shProg];
    if([frac getMaterial] != nil){
        MSVector4D* diffuse = [[frac getMaterial] diffuse];
        MSVector4D* ambient = [[frac getMaterial] ambient];
        float shininess = [[frac getMaterial] shininess];
        glUniform3fv(glGetUniformLocation(shProg, "diffuseColor"), 1, [diffuse getArrayStyleVector]);
        glUniform3fv(glGetUniformLocation(shProg, "ambientColor"), 1, [ambient getArrayStyleVector]);
        glUniform1f(glGetUniformLocation(shProg, "shininess"), shininess);

    }else{
        glUniform3fv(glGetUniformLocation(shProg, "diffuseColor"), 1, [[MSVectorND onesVector:3] getArrayStyleVector]);
        glUniform3fv(glGetUniformLocation(shProg, "ambientColor"), 1, [[MSVectorND onesVector:3] getArrayStyleVector]);
        glUniform1f(glGetUniformLocation(shProg, "shininess"), 1.0f);
    }

    glUniform3fv(glGetUniformLocation(shProg, "specularColor"), 1, [frac getColor]);
    glUniform3fv(glGetUniformLocation(shProg, "lightColor"), 1, [[[[world getLightSources]objectAtIndex:0]getColor]getArrayStyleVector]);
    glUniformMatrix4fv(glGetUniformLocation(shProg, "lightPosition"), 1, GL_FALSE, [[[[world getLightSources]objectAtIndex:0]getTranslation]matrixAsArray]);
#if macOS

    if (settings >> 3 == 1){
        glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
    }
    else{
        glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);

    }
#endif
    glBindBuffer(GL_ARRAY_BUFFER, [frac getBuffer]);
    glDrawArraysInstanced(GL_TRIANGLES, 0, (GLsizei)(3*[frac amountOfElemntsToLoadToGraphics]), 1);
    glBindVertexArray(0);
    glEnableVertexAttribArray(0);
}
-(instancetype)initWithWorld: (MSWorld*)w shadersFolderPath: (NSString*) path{
    self=[super init];
    if(self){
        self->renderThread=[[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
        self->shaderProgram = [MSEngineUtility shaderProgramFromFiles:path vertexShader:@"VShader.vsh" fragmentShader:@"FShader.fsh"];
        self->lightShaderProgram = [MSEngineUtility shaderProgramFromFiles:path vertexShader:@"VShader.vsh" fragmentShader:@"LightShader.fsh"];
        self->world=w;
        self->settings=0;
        glEnable(GL_DEPTH_TEST);
        glDepthFunc(GL_LEQUAL);
    }
    return self;
}
-(void)drawEverything{
    [self clear];
    for (MSPuppet* mod in [world getModels]){
        [self drawObject:mod withProgram:shaderProgram];
    }
    for(MSLightSource* light in [world getLightSources]){
        [self drawObject:light withProgram:lightShaderProgram];
    }
}
-(void)run{
    [self drawEverything];
}
-(void)updateCameraPositionInShader: (GLuint)shProg{
    MSCamera* cam = [world getCamera];
    [cam lockObject];
    glUniformMatrix4fv(glGetUniformLocation(shProg, "cameraTranslation.camTr"), 1, GL_FALSE, [[cam getTranslation] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(shProg, "cameraRotation"), 1, GL_FALSE, [[cam getRotation] matrixAsArray]);
    [cam unLockObject];
}
-(void)clear{
    glClearColor(0.0, 0.0, 0.0, 0.5);
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
}
-(void)setShaderProgram: (GLuint)program{
    self->shaderProgram=program;
}
-(void)loadTransformationFromModelToShader: (MSPositionedObject*) model shaderProgram: (GLuint) shProg{
    MSMatrixND* perspectiveMatrix = [MSTransformationManager perpsectiveWithFoV:120 aspectRatio:16.0f/9.0f near:0.1 far:1000];
    [model lockObject];
    glUniformMatrix4fv(glGetUniformLocation(shProg, "rotation"), 1, GL_FALSE,  [[model getRotation] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(shProg, "translation"), 1, GL_FALSE,  [[model getTranslation] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(shProg, "scale"), 1, GL_FALSE, [[model getScale] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(shProg, "projection"), 1, GL_FALSE, [perspectiveMatrix matrixAsArray]);
    [model unLockObject];
}
-(void)setSettings:(int)set{
    self->settings=set;
}
-(int)getSettings{
    return self->settings;
}
-(void)shouldRenderOnlyContour: (BOOL) value{
    settings=settings ^ 1<<3;
}
-(void)shouldRenderAmbient: (BOOL) value{
    settings=settings ^ 1<<0;
}
-(void)shouldRenderSpecular: (BOOL) value{
    settings=settings ^ 1<<1;
}
-(void)shouldRenderDiffuse: (BOOL) value{
    settings=settings ^ 1<<2;
}
@end
