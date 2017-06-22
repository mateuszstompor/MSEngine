//
//  MSShaderLoader.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//




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

#ifndef MSENGINEUTILITY_H
#define MSENGINEUTILITY_H
@interface MSEngineUtility : NSObject

-(instancetype)init NS_UNAVAILABLE;
+(instancetype)alloc NS_UNAVAILABLE;
+(GLuint)loadShader:(const char*)path type:(GLenum) type maxAmountOfCharacters:(unsigned long) maxAmount;
+(GLuint)createBasicShaderProgramWithVertexShader: (GLuint)vertexSh fragmentShader: (GLuint)fragmentSh;
+(GLuint)generateShaderProgramFromVertexShader: (const char*)vShader fragmentShader:(const char*)fShader;
+(void)lookForErrors;

@end
#endif
