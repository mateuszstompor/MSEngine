//
//  MSRenderOpenGL.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 28/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSRender.h"
#import "MSDrawableFraction.h"

#if macOS
#import <OpenGL/gl3.h>
#import <OpenGL/gl.h>
#endif

#if iOS
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES3/glext.h>
#endif

#ifndef MSRENDEROPENGL_H
#define MSRENDEROPENGL_H
@interface MSRenderOpenGL : NSObject  <MSRender>
{
    GLuint modelShaderProgram;
    GLuint lightShaderProgram;
    
    MSWorld* world;
  
    NSMutableDictionary<NSValue*,MSDrawableFraction*>* modelsLoadedToGraphics;
}

@property (nonatomic, copy) void (^beforeDrawAction)(void);
@property (nonatomic, copy) void (^afterDrawAction)(void);

-(instancetype)initWithWorld:(MSWorld *)world modelShader: (GLuint)mSh lightShader: (GLuint)lsh;

@end
#endif
