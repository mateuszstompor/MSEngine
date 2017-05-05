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
    GLuint pos = glGetAttribLocation(shProg, "position");
    glVertexAttribPointer(pos, 3, GL_FLOAT, GL_FALSE, 6*sizeof(GLfloat), 0);
    glEnableVertexAttribArray(pos);
    GLuint normalPosition = glGetAttribLocation(shProg, "normal");
    glVertexAttribPointer(normalPosition, 3, GL_FLOAT, GL_FALSE, 6*sizeof(GLfloat), (void*)(3*sizeof(GLfloat)));
    glEnableVertexAttribArray(normalPosition);
    glBindFragDataLocation(shProg, 0, "outColor");
    [self loadTransformationFromModelToShader: md shaderProgram:shProg];
    [self updateCameraPositionInShader: shProg];
    
    glUniform3fv(glGetUniformLocation(shProg, "fractionColor"), 1, [frac getColor]);
    glUniform3fv(glGetUniformLocation(shProg, "lightColor"), 1, [[[[world getLightSources]objectAtIndex:0]getColor]getArrayStyleVector]);
    glUniformMatrix4fv(glGetUniformLocation(shProg, "lightPosition"), 1, GL_FALSE, [[[[world getLightSources]objectAtIndex:0]getTranslation]matrixAsArray]);

    glDrawArrays(GL_TRIANGLES, 0, (GLsizei)(3l*3l*2l*[frac amountOfElemntsToLoadToGraphics]));
    glBindVertexArray(0);
    glEnableVertexAttribArray(0);
}
-(instancetype)initWithWorld: (MSWorld*)w vertexShader: (const char*)vsh fragmentShader:(const char*)fsh lightShader: (const char*) lfsh{
    self=[super init];
    if(self){
        self->renderThread=[[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
        self->shaderProgram=[MSEngineUtility generateShaderProgramFromVertexShader:vsh fragmentShader:fsh];
        self->lightShaderProgram=[MSEngineUtility generateShaderProgramFromVertexShader:vsh fragmentShader:lfsh];
        self->world=w;
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
    glUniformMatrix4fv(glGetUniformLocation(shProg, "cameraTranslation"), 1, GL_FALSE, [[cam getTranslation] matrixAsArray]);
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
@end
