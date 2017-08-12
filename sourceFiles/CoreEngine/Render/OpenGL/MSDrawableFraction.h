//
//  MSDrawableModel.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 28/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSPuppet.h"
#import "MSVertexData.h"

#if macOS
#import <OpenGL/gl3.h>
#endif

#if iOS
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES3/glext.h>
#endif

#ifndef MSDRAWABLEFRACTION_H
#define MSDRAWABLEFRACTION_H


@interface MSDrawableFraction : NSObject

{
    unsigned int indiciesToDraw;
    BOOL isLoadedToGraphicsCard;
    MSModelFraction* associatedFraction;
}

@property (atomic) GLuint vao;
@property (atomic) GLuint verticesBuffer;
@property (atomic) GLuint normalsBuffer;
@property (atomic) GLuint textureBuffer;


-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithFraction: (MSModelFraction*) pup;
-(BOOL)isloadedToGraphics;
-(void)loadToGraphics;
-(void)unloadFromGraphics;
-(unsigned int)indiciesToDraw;

@end

#endif
