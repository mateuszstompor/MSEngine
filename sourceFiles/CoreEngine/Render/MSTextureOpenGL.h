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
#endif

#ifndef MSTextureOpenGL_h
#define MSTextureOpenGL_h

@interface MSTextureOpenGL : MSTexture <MSRenderableTexture>

{
    GLuint textureID;
}

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initTextureFromFile: (NSString*) path NS_UNAVAILABLE;
-(instancetype)initFromTexture: (MSTexture*) texture;
-(instancetype)initFromOpenGLTexture: (GLuint) itsID width: (unsigned int) width height: (unsigned int) height;

@end

#endif
