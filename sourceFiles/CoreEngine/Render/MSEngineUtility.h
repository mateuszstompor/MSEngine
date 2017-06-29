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
-(instancetype)init     NS_UNAVAILABLE;
+(instancetype)alloc    NS_UNAVAILABLE;
//+(GLuint)loadShaderAtFolder:(NSString*) pathToFolder fileName:(NSString*) fileName type:(GLenum) shaderType;
//+(GLuint)createBasicShaderProgramWithVertexShader: (GLuint) vertexShader fragmentShader: (GLuint) fragmentShader;
+(GLuint)shaderProgramFromFiles: (NSString*) folderPath vertexShader: (NSString*) vShaderName fragmentShader: (NSString*) fShaderName;
@end

#endif
