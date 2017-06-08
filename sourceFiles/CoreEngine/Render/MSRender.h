//
//  MSRender.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPuppet.h"
#import "MSEngineUtility.h"
#import "MSWorld.h"

#if macOS
#import <OpenGL/gl3.h>
#import <OpenGL/gl.h>
#import <Cocoa/Cocoa.h>
#endif

#if iOS
#import <Foundation/Foundation.h>
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES3/glext.h>
#endif


#ifndef MSRENDER_H
#define MSRENDER_H
@interface MSRender : NSObject
{
    NSThread *renderThread;
    GLuint shaderProgram;
    GLuint lightShaderProgram;
    MSWorld* world;
    int settings;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithWorld: (MSWorld*)w vertexShader: (const char*)vsh fragmentShader:(const char*)fsh lightShader: (const char*) lfsh;
-(void)drawEverything;
-(void)run;
-(int)getSettings;
-(void)shouldRenderAmbient: (BOOL) value;
-(void)shouldRenderSpecular: (BOOL) value;
-(void)shouldRenderDiffuse: (BOOL) value;
-(void)shouldRenderOnlyContour: (BOOL) value;
@end
#endif
