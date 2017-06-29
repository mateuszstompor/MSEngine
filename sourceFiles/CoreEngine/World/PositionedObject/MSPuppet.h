//
//  MSpuppet.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 24/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MSPositionedObject.h"
#import "MSModelFraction.h"

#if macOS
#import <OpenGL/gl3.h>
#import <OpenGL/gl.h>
#import <Cocoa/Cocoa.h>
#endif

#if iOS
#import <OpenGLES/ES3/gl.h>
#endif





#ifndef MSPUPPET_H
#define MSPUPPET_H
@interface MSPuppet : NSObject <MSPositionedObject>

{

    MSMatrix4D* scale;
    MSMatrix4D* rotation;
    MSMatrix4D* translation;
    NSArray<MSModelFraction*>* model;
}
-(instancetype _Nullable)init NS_UNAVAILABLE;
-(instancetype _Nullable)initWithModel: (NSArray<MSModelFraction*>* _Nullable)md;
-(NSArray<MSModelFraction*>* _Nullable)getModelComponents;

@end
#endif
