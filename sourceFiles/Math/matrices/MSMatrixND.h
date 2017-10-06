//
//  MSMatrixND.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//




//IMPORTANT
//IMPORTANT matrix is column major unlike many C and C++ implementations
//IMPORTANT

#import <Foundation/Foundation.h>
#import "MSVectorND.h"

#ifndef MSMATRIXND_H
#define MSMATRIXND_H

@class MSVectorND;


@interface MSMatrixND : NSObject
{
    @protected
    int amountOfRows;
    int amountOfColumns;
    NSMutableArray<MSVectorND*>* matrix;
    float** cMatrix;
    float* asArrayMatrix;
}
+(instancetype)identityMatrix:(int const)dimension;
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithIdentityMatrix: (int const) dimension;
-(instancetype)initWithMatrix: (MSMatrixND const * const) matrixNS_DESIGNATED_INITIALIZER;
-(instancetype)initWithVectors:(int const)numberOfColumns, ... NS_DESIGNATED_INITIALIZER;
-(void)extendMatrixAboutColumn:(MSVectorND const * const)vec;
-(void)multiplyByScalar: (float)scalar;
-(float**)getColumnMajorArrayStyleMatrix;
-(MSVectorND*)multiplyByColumnVector: (MSVectorND*)vector;
-(MSVectorND*)safeMultiplyByColumnVector: (MSVectorND*)vector;
-(MSMatrixND*)multiplyByMatrix: (MSMatrixND*)otherMatrix;
-(MSMatrixND*)safeMultiplyByMatrix: (MSMatrixND*)otherMatrix;
-(MSVectorND*)getColumn: (int) columnIndex;
-(int)getAmountOfColumns;
-(int)getAmountOfRows;
-(BOOL)isEqualToMatrix: (MSMatrixND*) secondMatrix;
-(BOOL)isEqualToMatrix: (MSMatrixND*) secondMatrix withPrecision: (float) accuracy;
-(float*)matrixAsArray;
-(void)setValueAtRowIndex:(int) rowI andColumnIndex: (int) columnI value:(float)val;
-(float)getValueAtRowIndex:(int) row andColumnIndex: (int) column;
@end

typedef MSMatrixND MSMatrix4D;
typedef MSMatrixND MSMatrix3D;
typedef MSMatrixND MSMatrix2D;

#endif
