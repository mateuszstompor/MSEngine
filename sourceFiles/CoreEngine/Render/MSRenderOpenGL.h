  //
//  MSRenderOpenGL.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 28/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSRender.h"
#import "MSDrawableFraction.h"
#import "MSTextureOpenGL.h"

#if macOS
#import <OpenGL/gl3.h>
#endif

#if iOS
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES3/glext.h>
#endif

#ifndef MSRENDEROPENGL_H
#define MSRENDEROPENGL_H
@interface MSRenderOpenGL : MSRender

{
    GLuint modelShaderProgram;
    GLuint lightShaderProgram;
    NSMutableDictionary<NSValue*,MSDrawableFraction*>* modelsLoadedToGraphics;
    NSMutableDictionary<NSString*,MSTextureOpenGL*>* texturesLoadedToGraphics;
}

@end
#endif
