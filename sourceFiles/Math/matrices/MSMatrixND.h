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

#define MSMATRIX_ASSOCIATED_TYPE float
#define MSMATRIX_IDENTITY_MATRIX_VALUE 1.0f
#define MSMATRIX_ZERO_VALUE 0.0f
#define MSMATRIX_MINIMAL_INDEX 0
#define MSMATRIX_ASSOCIATED_INT_TYPE int

@class MSVectorND;


@interface MSMatrixND : NSObject

+(instancetype)identityMatrix:(int const)dimension;

-(instancetype)init NS_UNAVAILABLE;

-(instancetype)initWithRows: (int const) rows columns: (int const) columns NS_DESIGNATED_INITIALIZER;
-(instancetype)initWithIdentityMatrix: (int const) dimension;
-(instancetype)initWithMatrix: (MSMatrixND const * const) matrix;
-(instancetype)initWithVectors: (NSArray<MSVectorND*>*) vectors;
-(void)multiplyByScalar: (MSMATRIX_ASSOCIATED_TYPE)scalar;
-(MSVectorND*)multiplyByColumnVector: (MSVectorND*)vector;
-(MSVectorND*)safeMultiplyByColumnVector: (MSVectorND*)vector;
-(MSMatrixND*)multiplyByMatrix: (MSMatrixND*)otherMatrix;
-(MSMatrixND*)safeMultiplyByMatrix: (MSMatrixND*)otherMatrix;
-(int)getAmountOfColumns;
-(int)getAmountOfRows;
-(BOOL)isEqualToMatrix: (MSMatrixND*) secondMatrix;
-(BOOL)isEqualToMatrix: (MSMatrixND*) secondMatrix withPrecision: (MSMATRIX_ASSOCIATED_TYPE) accuracy;
-(MSMATRIX_ASSOCIATED_TYPE*)matrixAsArray;
-(void)setValueAtRowIndex:(int) rowI andColumnIndex: (int) columnI value:(MSMATRIX_ASSOCIATED_TYPE)val;
-(MSMATRIX_ASSOCIATED_TYPE)getValueAtRowIndex:(int) row andColumnIndex: (int) column;

@end

typedef MSMatrixND MSMatrix4D;
typedef MSMatrixND MSMatrix3D;
typedef MSMatrixND MSMatrix2D;

#endif
