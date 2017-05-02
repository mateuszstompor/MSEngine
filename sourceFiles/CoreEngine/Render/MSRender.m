//
//  MSRender.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSRender.h"

@implementation MSRender
-(void)drawObject: (MSPuppet*)model{
    for(MSModelFraction* frac in [model getModelComponents]){
        [self drawFraction:frac model:model];
    }
}
-(void)drawFraction:(MSModelFraction*)frac model:(MSPuppet*)md{
    glUseProgram(shaderProgram);
    glBindVertexArray([frac getVerticiesVAO]);
    glBindBuffer(GL_ARRAY_BUFFER, [frac getBuffer]);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, [frac getElementsOrderBuffer]);
    GLuint pos = glGetAttribLocation(shaderProgram, "position");
    glVertexAttribPointer(pos, 3, GL_FLOAT, GL_FALSE, 3*sizeof(GLfloat), 0);
    glEnableVertexAttribArray(pos);
    glBindFragDataLocation(shaderProgram, 0, "outColor");
    [self loadTransformationFromModelToShader: md];
    [self updateCameraPositionInShader];
    GLuint posOfColor = glGetUniformLocation(shaderProgram, "fractionColor");
    glUniform3fv(posOfColor, 1, [frac getColor]);
    GLuint amountOfElements=(int)[frac amountOfTriangleElements];
    //glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LEQUAL);
    glDrawElements(GL_TRIANGLES, amountOfElements, GL_UNSIGNED_INT, glMapBuffer(GL_ELEMENT_ARRAY_BUFFER, GL_READ_ONLY));
    glBindVertexArray(0);
    glEnableVertexAttribArray(0);

}
-(instancetype)initWithWorld: (MSWorld*)w andProgram: (GLuint)program{
    self=[super init];
    if(self){
        self->renderThread=[[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
        self->shaderProgram=program;
        self->world=w;
    }
    return self;
}
-(void)drawEverything{
    glUseProgram(shaderProgram);
    [self clear];
    for (MSPuppet* mod in [world getModels]){
        [self drawObject:mod];
    }
    glUseProgram(0);
}
-(void)run{
    [self drawEverything];
}
-(void)updateCameraPositionInShader{
    MSCamera* cam = [world getCamera];
    [cam lockObject];
    glUniformMatrix4fv(glGetUniformLocation(shaderProgram, "cameraTranslation"), 1, GL_FALSE, [[cam getTranslation] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(shaderProgram, "cameraRotation"), 1, GL_FALSE, [[cam getRotation] matrixAsArray]);
    [cam unLockObject];
}
-(void)clear{
    glClearColor(0.0, 0.0, 0.0, 0.5);
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
}
-(void)setShaderProgram: (GLuint)program{
    self->shaderProgram=program;
}
-(void)loadTransformationFromModelToShader: (MSPositionedObject*) model{
    MSMatrixND* perspectiveMatrix = [MSTransformationManager perpsectiveWithFoV:120 aspectRatio:16.0f/9.0f near:0.1 far:1000];
    [model lockObject];
    glUniformMatrix4fv(glGetUniformLocation(shaderProgram, "rotation"), 1, GL_FALSE,  [[model getRotation] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(shaderProgram, "translation"), 1, GL_FALSE,  [[model getTranslation] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(shaderProgram, "scale"), 1, GL_FALSE, [[model getScale] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(shaderProgram, "projection"), 1, GL_FALSE, [perspectiveMatrix matrixAsArray]);
    [model unLockObject];
}
@end
