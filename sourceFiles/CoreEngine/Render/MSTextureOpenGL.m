//
//  MSTextureOpenGL.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 12/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSTextureOpenGL.h"

@implementation MSTextureOpenGL

@synthesize textureID = _textureID;

-(instancetype)initFromTexture: (MSTexture*) texture withLoadingToGraphics: (BOOL) shoudLoad;{
    self = [super init];
    if (self) {
        self->width = texture->width;
        self->height = texture->height;
        self->_textureID = 0;
        self->data = texture->data;
        texture->data = nil;
        self.name = [[NSString alloc] initWithString:texture.name];
        if (shoudLoad){
            [self loadToGraphicsMemory];
        }
    }
    return self;
}

-(void)loadToGraphicsMemory{
        glGenTextures(1, &self->_textureID);
        glBindTexture(GL_TEXTURE_2D, _textureID);
//        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
//        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
//        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
//        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, (GLsizei)width, (GLsizei)height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);

//        glGenerateMipmap(GL_TEXTURE_2D);
    GLenum err = glGetError();
    if (err != GL_NO_ERROR){
        NSLog(@"Error uploading texture. glError: 0x%04X, texture name \"%@\"", err, [self name]);
    }
    glBindTexture(GL_TEXTURE_2D, 0);
    
}

-(void) bindItself{
    if(![self isLoadedToGraphicsMemory]){
        [self loadToGraphicsMemory];
    }
    glBindTexture(GL_TEXTURE_2D, _textureID);
}

-(void) deallocateFromGraphicsMemory{
    glDeleteTextures(1, &self->_textureID);
    self->_textureID = 0;
}

-(BOOL)isLoadedToGraphicsMemory{
    return self->_textureID != 0;
}

-(void)dealloc{
    [self deallocateFromGraphicsMemory];
}

@end

