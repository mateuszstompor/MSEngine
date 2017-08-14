//
//  MSVectorND.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSMathException.h"
#import "MSMatrixND.h"

#import <Foundation/Foundation.h>
#import <stdlib.h>
#import <stdio.h>

#ifndef MSVECTORND_H
#define MSVECTORND_H

@class MSMatrixND;

//"safe" as prefix of function means that function tests for vector dimension mismatch

@interface MSVectorND : NSObject

{
    @protected float *components;
    @protected unsigned int dimension;
}

+(instancetype)onesVector: (unsigned int const)dimension;
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithZerosExceptIndex: (unsigned int const) index number:(float const) num dimensionOfVector: (unsigned int const) dim;
-(instancetype)initZeroVecWithDimension: (unsigned int const) dim;
-(instancetype)initVecWithDimension: (unsigned int const) dim;
-(instancetype)initWithComponents: (unsigned int const) dim, ...;
-(instancetype)initWithArrayOfComponents: (unsigned int const) dim components: (float const * const) array;
-(instancetype)initWithVector: (MSVectorND const * const) vec;

-(void)safeAdd: (MSVectorND const * const) vec;
-(void)add: (MSVectorND const * const) vec;

-(MSVectorND*)newVectorFromAddition: (MSVectorND const * const) vec;
-(MSVectorND*)newVectorFromSafeAddition: (MSVectorND const * const) vec;


-(void)safeSubtract: (MSVectorND const * const) vec;
-(void)subtract: (MSVectorND const * const) vec;

-(MSVectorND*)newVectorFromSubtraction: (MSVectorND const * const) vec;
-(MSVectorND*)newVectorFromSafeSubtraction: (MSVectorND const * const) vec;


-(float const*)getArrayStyleVector;
-(void)multiplyByScalar: (float const) scalar;


-(float)length;
-(float)lengthSquared;

-(void)safeSetValueAtIdenx:(unsigned int const)index value: (float)val;
-(void)setValueAtIdenx:(unsigned int const)index value: (float)val;
-(void)normalize;

-(float)safeValueAtIndex:(unsigned int const)index;
-(float)valueAtIndex:(unsigned int const)index;

-(float)dotProduct: (MSVectorND const *) vec;
-(float)safeDotProduct: (MSVectorND const *) vec;

-(void)matchDimensions: (MSVectorND const *) vec;
-(int)getDimension;

-(BOOL)isEqualToVector: (MSVectorND*) vec;
-(BOOL)safeIsEqualToVector: (MSVectorND*) vec;

-(BOOL)isEqualToVector: (MSVectorND*) vec withMaxDifference: (float) difference;
-(BOOL)safeIsEqualToVector: (MSVectorND*) vec withMaxDifference: (float) difference;

-(MSVectorND*)crossProduct: (MSVectorND*)vector;
-(MSVectorND*)safeCrossProduct: (MSVectorND*)vector;

-(MSVectorND*)multiplyByMatrix: (MSMatrixND*) matrix;
-(MSVectorND*)safeMultiplyByMatrix: (MSMatrixND*) matrix;

@end

typedef MSVectorND MSVector4D;
typedef MSVectorND MSVector3D;
typedef MSVectorND MSVector2D;

#endif
