//
//  MSModelFraction.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#if macOS
#import <OpenGL/gl3.h>
#import <OpenGL/gl.h>
#import <Cocoa/Cocoa.h>
#endif

#if iOS
#import <Foundation/Foundation.h>
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>
#endif

#import "MSPoint.h"
#import "MSModelFace.h"
#import "MSVectorND.h"
#import "MSMaterial.h"

#ifndef MSMODELFRACTION_H
#define MSMODELFRACTION_H
@interface MSModelFraction : NSObject

@property (atomic) NSMutableArray<MSPoint3D*>* vertices;
@property (atomic) NSMutableArray<MSPoint3D*>* normals;
@property (atomic) NSMutableArray<MSPoint2D*>* textureCoordinates;
@property (atomic) NSMutableArray<MSModelFace*>* facesData;
@property (atomic) MSMaterial* material;
@property (atomic) NSString* name;
@property (atomic) NSValue* uniqueName;

-(instancetype)init;
-(NSValue*)getUniqueName;

@end
#endif
