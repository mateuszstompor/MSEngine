//
//  MSRender.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <OpenGL/gl3.h>
#import "MSPuppet.h"
#import "MSEngineUtility.h"
#import "MSWorld.h"


#ifndef MSRENDER_H
#define MSRENDER_H
@interface MSRender : NSObject
{
    NSThread *renderThread;
    GLuint shaderProgram;
    GLuint lightShaderProgram;
    MSWorld* world;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithWorld: (MSWorld*)w vertexShader: (const char*)vsh fragmentShader:(const char*)fsh lightShader: (const char*) lfsh;
-(void)drawEverything;
-(void)run;
@end
#endif
