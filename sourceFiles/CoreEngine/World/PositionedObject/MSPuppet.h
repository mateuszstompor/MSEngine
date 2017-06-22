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
@interface MSPuppet : MSPositionedObject
{
    NSArray<MSModelFraction*>* model;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithScale: (MSMatrix4D*)scaleM rotation: (MSMatrix4D*)rotationM translation:(MSMatrix4D*)trM NS_UNAVAILABLE;
-(instancetype)initWithModel: (NSArray<MSModelFraction*>*)md;
-(instancetype)initWithScale: (MSMatrix4D*)scaleM rotation: (MSMatrix4D*)rotationM translation:(MSMatrix4D*)trM model: (NSArray<MSModelFraction*>*)mod;
-(NSArray<MSModelFraction*>*)getModelComponents;
@end
#endif
