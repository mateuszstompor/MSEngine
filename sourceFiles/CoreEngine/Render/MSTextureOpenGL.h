//
//  MSTextureOpenGL.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 12/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSTexture.h"
#import "MSRenderableTexture.h"

#if macOS
#import <OpenGL/gl3.h>
#endif

#if iOS
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES1/gl.h>
#endif

#ifndef MSTextureOpenGL_h
#define MSTextureOpenGL_h

@interface MSTextureOpenGL : MSTexture <MSRenderableTexture>

@property (readonly) GLuint textureID;

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initTextureFromFile: (NSString*) path NS_UNAVAILABLE;
-(instancetype)initFromTexture: (MSTexture*) texture withLoadingToGraphics: (BOOL) shoudLoad;
-(instancetype)initTextureFromFile: (NSString*) path withLoadingToGraphics: (BOOL) shoudLoad;

@end

#endif
