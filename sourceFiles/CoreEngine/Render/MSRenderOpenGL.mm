//
//  MSRenderOpenGL.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 28/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSRenderOpenGL.h"
#include <string>

@implementation MSRenderOpenGL

@synthesize settings;

-(instancetype)initWithWorld:(MSWorld *)w modelShader: (GLuint)mSh lightShader: (GLuint)lsh{
    self=[super init];
    if(self){
        self->world=w;
        self->modelsLoadedToGraphics = [[NSMutableDictionary alloc] init];
        self->lightShaderProgram=lsh;
        self->modelShaderProgram=mSh;
        self->settings=0;
        self->lastFrameRate=0;
        self->lastSecond=[NSDate date];
        [self loadObjectsToGraphics];
        [self setUpOpenGLOptions];
    }
    return self;
}
-(void)setUpOpenGLOptions{
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LEQUAL);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
}
-(void)loadObjectsToGraphics{
    [self loadPuppetsToGraphics: [world getModels] withProgram:modelShaderProgram];
    [self loadPuppetsToGraphics: [world getLightSources] withProgram:lightShaderProgram];
}

-(void)loadPuppetsToGraphics: (NSArray<MSPuppet*>*) puppets withProgram: (GLuint) shadingProgram {
    for(MSPuppet* model in puppets){
        for(MSModelFraction* frac in [model getModelComponents]){
            MSDrawableFraction* drawableFraction = [[MSDrawableFraction alloc] initWithFraction:frac];
            [modelsLoadedToGraphics setObject:drawableFraction forKey:[frac getUniqueName]];
            [self setShaderFeeding:drawableFraction program:shadingProgram];
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
    
    if([fraction textureBuffer] != 0){
        //texture data
        glBindBuffer(GL_ARRAY_BUFFER, [fraction textureBuffer]);
        glVertexAttribPointer(glGetAttribLocation(shaderProgram, "textureCoordinates"), 2, GL_FLOAT, GL_FALSE, 2*sizeof(float), 0);
        glEnableVertexAttribArray(glGetAttribLocation(shaderProgram, "textureCoordinates"));
        
    }
    
    #if macOS
    glBindFragDataLocation(shaderProgram, 0, "outColor");
    #endif
    
    glBindVertexArray(0);
}
-(void)setBehavioureforeEachDraw: (void (^_Nullable)(void))block{
    self->_beforeDrawAction=block;
}
-(void)drawScene{
    [self countFrameRate];
    [self clear];
    [self drawModels];
    [self drawLights];
}
-(void)drawLights{
    glUseProgram(lightShaderProgram);
    [self setUpCameraUniforms: lightShaderProgram];
    for(MSPointLight* light in [world getLightSources]){
        glUniform3fv(glGetUniformLocation(lightShaderProgram, "color"), 1, [[light color]getArrayStyleVector]);
        [self drawPuppet:light withProgram:lightShaderProgram];
    }
    glUseProgram(0);
}

-(float)getCurrentFrameRate{
    return self->lastFrameRate;
}

-(void)countFrameRate{
    static unsigned int amountOfFramesRendered = 0;
    NSDate *now = [NSDate date];
    NSTimeInterval executionTime = [now timeIntervalSinceDate:lastSecond];
    if(executionTime > 1.0f){
        self->lastFrameRate = amountOfFramesRendered/executionTime;
        amountOfFramesRendered=0;
        lastSecond=now;
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
            
            if([[frac material] associatedTexture] != nil){
                id<MSRenderableTexture> texture = [[self->world getAvailavleMaterials] getTextureWithName:[[frac material] associatedTexture]];
                if (texture != nil){
                    [texture bindItself];
                    glUniform1i(glGetUniformLocation(prog, "material.hasTexture"), YES);
                }
                else{
                    glUniform1i(glGetUniformLocation(prog, "material.hasTexture"), NO);
                }
            }else{
                glUniform1i(glGetUniformLocation(prog, "material.hasTexture"), NO);
            }
            
            glUniform3fv(glGetUniformLocation(prog, "material.specular"), 1, [specular getArrayStyleVector]);
            glUniform3fv(glGetUniformLocation(prog, "material.diffuse"), 1, [diffuse getArrayStyleVector]);
            glUniform3fv(glGetUniformLocation(prog, "material.ambient"), 1, [ambient getArrayStyleVector]);
            glUniform1f(glGetUniformLocation(prog, "material.shininess"), shininess);
            glUniform1f(glGetUniformLocation(prog, "material.alpha"), [[frac material] transparency]);
            
        }else{
            glUniform3fv(glGetUniformLocation(prog, "material.specular"), 1, [[MSVectorND onesVector:3] getArrayStyleVector]);
            glUniform3fv(glGetUniformLocation(prog, "material.diffuse"), 1, [[MSVectorND onesVector:3] getArrayStyleVector]);
            glUniform3fv(glGetUniformLocation(prog, "material.ambient"), 1, [[MSVectorND onesVector:3] getArrayStyleVector]);
            glUniform1f(glGetUniformLocation(prog, "material.shininess"), 0.0f);
            glUniform1f(glGetUniformLocation(prog, "material.alpha"), 1.0f);
            glUniform1i(glGetUniformLocation(prog, "material.hasTexture"), NO);

        }
}
-(void)setUpCameraUniforms: (GLuint) shaderProgram{
    MSCamera* cam = [world getCamera];
    glUniformMatrix4fv(glGetUniformLocation(shaderProgram, "camera.projection"), 1, GL_FALSE, [[cam getProjectionMatrix] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(shaderProgram, "camera.translation"), 1, GL_FALSE, [[cam translation] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(shaderProgram, "camera.rotation"), 1, GL_FALSE, [[cam rotation] matrixAsArray]);
}
-(void)drawModels{
    glUseProgram(modelShaderProgram);
    glUniform1i(glGetUniformLocation(modelShaderProgram, "omniLightsAmount"), (int)[[world getLightSources] count]);
    [self setUpCameraUniforms: modelShaderProgram];
    
    std::string color = "light[0].color";
    std::string power = "light[0].power";
    std::string scale = "light[0].scale";
    std::string rotation = "light[0].rotation";
    std::string translation = "light[0].translation";

    for(MSPuppet* puppet in [world getModels]){
        
        for(long lightIndex=0; lightIndex<[[world getLightSources] count]; ++lightIndex){
            
            color[6]=48+lightIndex;
            power[6]=48+lightIndex;
            scale[6]=48+lightIndex;
            rotation[6]=48+lightIndex;
            translation[6]=48+lightIndex;
            glUniform3fv(glGetUniformLocation(modelShaderProgram, color.c_str()), 1, [[[[world getLightSources]objectAtIndex:lightIndex] color]getArrayStyleVector]);
            glUniform1f(glGetUniformLocation(modelShaderProgram, power.c_str()), [[[world getLightSources] objectAtIndex:lightIndex] power]);
            glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, translation.c_str()), 1, GL_FALSE, [[[[world getLightSources]objectAtIndex:lightIndex]translation]matrixAsArray]);
            glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, scale.c_str()), 1, GL_FALSE, [[[[world getLightSources]objectAtIndex:lightIndex]scale]matrixAsArray]);
            glUniformMatrix4fv(glGetUniformLocation(modelShaderProgram, rotation.c_str()), 1, GL_FALSE, [[[[world getLightSources]objectAtIndex:lightIndex]rotation]matrixAsArray]);
        }
        [self drawPuppet:puppet withProgram:modelShaderProgram];
    }
    glUseProgram(0);
}
-(void)drawPuppet: (MSPuppet*)puppet withProgram: (GLuint) shaderProgram {
    glUniformMatrix4fv(glGetUniformLocation(shaderProgram, "transformation.rotation"), 1, GL_FALSE,  [[puppet rotation] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(shaderProgram, "transformation.translation"), 1, GL_FALSE,  [[puppet translation] matrixAsArray]);
    glUniformMatrix4fv(glGetUniformLocation(shaderProgram, "transformation.scale"), 1, GL_FALSE, [[puppet scale] matrixAsArray]);
    
    NSMutableArray<MSModelFraction*>* transparentFractions = [[NSMutableArray alloc] init];
    
    for(MSModelFraction* fraction in [puppet getModelComponents]){
        if ([fraction isOpaque]){
            [self setUpUniforms:fraction shaderProgram:shaderProgram];
            MSDrawableFraction* modelToDraw = [modelsLoadedToGraphics objectForKey:[fraction getUniqueName]];
            if ([modelToDraw indiciesToDraw] > 0){
                glBindVertexArray([modelToDraw vao]);
                //NSLog(@"%i", (GLsizei)([modelToDraw indiciesToDraw]));
                glDrawArraysInstanced(GL_TRIANGLES, 0,(GLsizei)([modelToDraw indiciesToDraw]), 1);
                glBindVertexArray(0);
            }
        }else{
//            [transparentFractions ap]
            [transparentFractions addObject:fraction];
        }

        
    }
    for(MSModelFraction* fraction in transparentFractions){
            [self setUpUniforms:fraction shaderProgram:shaderProgram];
            MSDrawableFraction* modelToDraw = [modelsLoadedToGraphics objectForKey:[fraction getUniqueName]];
            if ([modelToDraw indiciesToDraw] > 0){
                glBindVertexArray([modelToDraw vao]);
                //NSLog(@"%i", (GLsizei)([modelToDraw indiciesToDraw]));
                glDrawArraysInstanced(GL_TRIANGLES, 0,(GLsizei)([modelToDraw indiciesToDraw]), 1);
                glBindVertexArray(0);
            }
    }
}
-(void)clear{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
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
