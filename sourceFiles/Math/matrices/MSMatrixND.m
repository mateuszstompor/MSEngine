//
//  MSMatrixND.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSMatrixND.h"
#import <Foundation/Foundation.h>


@implementation MSMatrixND

{
@protected
    int amountOfRows;
    int amountOfColumns;
    MSMATRIX_ASSOCIATED_TYPE* matrix;
}

-(instancetype)initWithRows: (int const) rows columns: (int const) columns {
    self = [super init];
    if (self) {
        self->matrix = (MSMATRIX_ASSOCIATED_TYPE*)malloc(rows*columns*sizeof(MSMATRIX_ASSOCIATED_TYPE));
        self->amountOfRows = rows;
        self->amountOfColumns = columns;
    }
    return self;
}
-(instancetype)initWithValue: (int const) rows columns: (int const) columns value: (MSMATRIX_ASSOCIATED_TYPE) value {
    self = [self initWithRows:rows columns:columns];
    if (self) {
        for (MSMATRIX_ASSOCIATED_INT_TYPE i = MSMATRIX_MINIMAL_INDEX; i < self->amountOfColumns * self->amountOfRows; ++i) {
            *(matrix + i) = value;
        }
    }
    return self;
}

-(instancetype)initWithVectors: (NSArray<MSVectorND*>*) vectors {
    self = [self initWithRows:[[vectors objectAtIndex:0] getDimension] columns:[vectors count]];
    if(self){
        for (int i=0; i<[vectors count]; ++i) {
            for (int j=0; j<[[vectors objectAtIndex:i] getDimension]; ++j) {
                *(matrix + i*amountOfRows + j) = [[vectors objectAtIndex:i] valueAtIndex:j];
            }
        }
    }
    return self;
}

-(instancetype)initWithIdentityMatrix: (int const) dimension{
    self = [self initWithValue:dimension columns:dimension value: MSMATRIX_ZERO_VALUE];
    if(self){
        for (int i=MSMATRIX_MINIMAL_INDEX; i<dimension; ++i) {
            *(self->matrix+(i*dimension)+i) = MSMATRIX_IDENTITY_MATRIX_VALUE;
        }
    }
    return self;
}
-(instancetype)initWithMatrix: (MSMatrixND const * const) matrixToCopy{
    self = [self initWithRows:matrixToCopy->amountOfRows columns:matrixToCopy->amountOfColumns];
    if(self){
        memcpy(self->matrix, matrixToCopy->matrix, self->amountOfColumns * self->amountOfRows);
    }
    return self;
}
-(void)multiplyByScalar: (MSMATRIX_ASSOCIATED_TYPE)scalar{
    for(int i=MSMATRIX_MINIMAL_INDEX; i<self->amountOfColumns*self->amountOfRows; ++i) {
        *(self->matrix+i) *= scalar;
    }
}
-(float*)matrixAsArray{
    return self->matrix;
}
-(MSVectorND*)multiplyByColumnVector: (MSVectorND*)vector{
    MSMATRIX_ASSOCIATED_TYPE result[amountOfColumns];
    for(int outerIterator = MSMATRIX_MINIMAL_INDEX; outerIterator<amountOfRows; ++outerIterator){
        MSMATRIX_ASSOCIATED_TYPE sum = MSMATRIX_ZERO_VALUE;
        for(int innerIterator = MSMATRIX_MINIMAL_INDEX; innerIterator<amountOfColumns; ++innerIterator){
            sum += *(matrix + self->amountOfRows*outerIterator + innerIterator) * *([vector getArrayStyleVector] + innerIterator);
        }
        result[outerIterator]=sum;
    }
    return [[MSVectorND alloc] initWithArrayOfComponents:amountOfRows components:result];
}
-(MSVectorND*)safeMultiplyByColumnVector: (MSVectorND*)vector{
    if(amountOfRows == 1){
        [NSException raise:@"It would be dot product!" format:@"Unsupported operation"];
    }
    if([vector getDimension] != amountOfColumns){
        [NSException raise: @"Cannot multiply" format: @"Amount of columns in array was %i and in vec %i", amountOfColumns, [vector getDimension]];
    }
    return [self multiplyByColumnVector:vector];
}
//-(MSMatrixND*)safeMultiplyByMatrix: (MSMatrixND*)otherMatrix{
//    if(amountOfColumns!=otherMatrix->amountOfRows){
//        [NSException raise:@"Cannot multiply" format:@"Amount of columns in first matrix is not matching amount of rows in second"];
//    }
//    [NSException raise:@"Not implemented" format:@""];
//    return nil;
//}
+(instancetype)identityMatrix:(int const)dimension{
    return [[MSMatrixND alloc] initWithIdentityMatrix:dimension];
}

-(MSMatrixND*)multiplyByMatrix: (MSMatrixND*)otherMatrix{
    MSMatrixND* resultMatrix = [[MSMatrixND alloc] initWithRows:self->amountOfRows columns:otherMatrix->amountOfColumns];
    for(int outerIterator = 0; outerIterator < self->amountOfRows; ++outerIterator) {
        for (int innerIterator = 0; innerIterator < self->amountOfColumns; ++innerIterator) {
            float sum = 0.0f;
            for (int i=0; i < amountOfColumns; ++ i) {
                int leftmatrix = amountOfRows*i + outerIterator;
                int rightmatrix = amountOfRows*innerIterator + i;
                float result = *(self->matrix + leftmatrix) * *(otherMatrix->matrix + rightmatrix);
                sum += result;
            }
            [resultMatrix setValueAtRowIndex:outerIterator andColumnIndex:innerIterator value:sum];
        }
    }
    return resultMatrix;
}

-(BOOL)isEqualToMatrix: (MSMatrixND*) secondMatrix{
    return [self isEqualToMatrix:secondMatrix withPrecision:0.0f];
}

-(BOOL)isEqualToMatrix: (MSMatrixND*) secondMatrix withPrecision: (MSMATRIX_ASSOCIATED_TYPE) accuracy{
    for (int i=MSMATRIX_MINIMAL_INDEX; i<(self->amountOfColumns * self->amountOfRows); ++i){
        MSMATRIX_ASSOCIATED_TYPE difference = (self->matrix[i] - secondMatrix->matrix[i]) * (self->matrix[i] - secondMatrix->matrix[i]);
        if(difference>(accuracy*accuracy)){
            return false;
        }
    }
    return true;
}
-(void)safeSetValueAtRowIndex: (int) row andColumnIndex: (int) column value: (MSMATRIX_ASSOCIATED_TYPE) value {
    //check rows as well
    // TODO
    if(column<MSMATRIX_MINIMAL_INDEX || column>=amountOfColumns){
        [NSException raise:@"Index out of bounds!" format:@"Wanted column with index %i, mat has only %i",column,amountOfColumns];
    }
    [self setValueAtRowIndex:row andColumnIndex:column value:value];
}
-(void)setValueAtRowIndex: (int) row andColumnIndex: (int) column value: (MSMATRIX_ASSOCIATED_TYPE) value {
    *(self->matrix + self->amountOfRows * column + row) = value;
}
-(int)getAmountOfColumns{
    return self->amountOfColumns;
}
-(int)getAmountOfRows{
    return self->amountOfRows;
}
-(void)dealloc{
    free(self->matrix);
}
-(MSMATRIX_ASSOCIATED_TYPE)getValueAtRowIndex:(int) row andColumnIndex: (int) column {
    return *(self->matrix + self->amountOfRows * column + row);
}
@end
