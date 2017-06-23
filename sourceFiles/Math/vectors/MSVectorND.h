//
//  MSVectorND.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdlib.h>
#import <stdio.h>

#ifndef MSVECTORND_H
#define MSVECTORND_H


@interface MSVectorND : NSObject
{
    float *components;
    int dimension;
}
+(instancetype)onesVector: (int)dimension;
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithZerosExceptIndex: (int) index number:(float) num dimensionOfVector: (int) dim;
-(instancetype)initZeroVecWithDimension: (int const) dim;
-(instancetype)initWithComponents: (int const) dim, ...;
-(instancetype)initWithArrayOfComponents: (int const) dim components: (float const * const) array NS_DESIGNATED_INITIALIZER;
-(instancetype)initWithVector: (MSVectorND const * const) vec;
-(void)add: (MSVectorND const * const) vec;
-(void)subtract: (MSVectorND const * const) vec;
-(float*)getArrayStyleVector;
-(void)printVector;
-(void)multiplyByScalar: (float const) scalar;
-(float)length;
-(void)setValueAtIdenx:(int)index value: (float)val;
-(void)normalize;
-(float)valueAtIndex:(int)index;
-(float)dotProduct: (MSVectorND const * const) vec;
-(void)checkDimensions: (MSVectorND const * const) vec;
-(int)getDimension;
@end

typedef MSVectorND MSVector4D;
typedef MSVectorND MSVector3D;
typedef MSVectorND MSVector2D;
#endif
