//
//  MSRender.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import "MSWorld.h"
#import <Foundation/Foundation.h>
#import <OpenGL/gl3.h>
#import "MSPuppet.h"


#ifndef MSRENDER_H
#define MSRENDER_H
@interface MSRender : NSObject
{
    NSThread *renderThread;
    GLuint shaderProgram;
    MSWorld* world;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithWorld: (MSWorld*)w andProgram: (GLuint)program;
-(void)drawEverything;
-(void)drawObject: (MSPuppet*)model;
-(void)setShaderProgram: (GLuint)program;
-(void)drawFraction:(MSModelFraction*)frac model:(MSPuppet*)md;
-(void)run;
@end
#endif
