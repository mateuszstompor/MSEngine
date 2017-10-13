//
//  MSTextureOpenGL.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 12/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSTextureOpenGL.h"

@implementation MSTextureOpenGL

-(instancetype)initFromTexture: (MSTexture*) texture{
    self = [super init];
    if (self) {
        self->width = texture->width;
        self->height = texture->height;
        self->textureID = 0;
        self->data = texture->data;
        self->name = [[NSString alloc] initWithString:[texture getName]];
        [self loadToGraphicsMemory];
    }
    return self;
}

-(NSString*)getName {
    return self->name;
}

-(unsigned int)getUniqueID {
    return self->textureID;
}

-(instancetype)initFromOpenGLTexture: (GLuint) itsID width: (unsigned int) wid height: (unsigned int) hei {
    self = [super init];
    if (self) {
        self->width = wid;
        self->height = hei;
        self->textureID = itsID;
    }
    return self;
}

-(void)loadToGraphicsMemory{
        glGenTextures(1, &self->textureID);
        glBindTexture(GL_TEXTURE_2D, textureID);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
        glGenerateMipmap(GL_TEXTURE_2D);
    GLenum err = glGetError();
    if (err != GL_NO_ERROR){
        NSLog(@"Error uploading texture. glError: 0x%04X, texture name \"%@\"", err, [self getName]);
    }
    glBindTexture(GL_TEXTURE_2D, 0);
    
}

-(void) deallocateFromGraphicsMemory{
    glDeleteTextures(1, &self->textureID);
    self->textureID = 0;
}

-(void) clean{
    [self deallocateFromGraphicsMemory];
}

@end

