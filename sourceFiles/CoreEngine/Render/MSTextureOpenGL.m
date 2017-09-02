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
        self.name = texture.name;
        texture.name = nil;
        if (shoudLoad){
            [self loadToGraphicsMemory];
        }
    }
    return self;
}

-(void)loadToGraphicsMemory{
        glGenTextures(1, &self->_textureID);
        glBindTexture(GL_TEXTURE_2D, _textureID);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);    
//            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
//            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glGenerateMipmap(GL_TEXTURE_2D);
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

