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
    MSMATRIX_ASSOCIATED_INT_TYPE amountOfRows;
    MSMATRIX_ASSOCIATED_INT_TYPE amountOfColumns;
    MSMATRIX_ASSOCIATED_TYPE* matrix;
}

-(instancetype)initWithRows: (MSMATRIX_ASSOCIATED_INT_TYPE const) rows columns: (MSMATRIX_ASSOCIATED_INT_TYPE const) columns {
    self = [super init];
    if (self) {
        self->matrix = (MSMATRIX_ASSOCIATED_TYPE*)malloc(rows*columns*sizeof(MSMATRIX_ASSOCIATED_TYPE));
        self->amountOfRows = rows;
        self->amountOfColumns = columns;
    }
    return self;
}
-(instancetype)initWithValue: (MSMATRIX_ASSOCIATED_INT_TYPE const) rows columns: (MSMATRIX_ASSOCIATED_INT_TYPE const) columns value: (MSMATRIX_ASSOCIATED_TYPE) value {
    self = [self initWithRows:rows columns:columns];
    if (self) {
        for (MSMATRIX_ASSOCIATED_INT_TYPE i = MSMATRIX_MINIMAL_INDEX; i < self->amountOfColumns * self->amountOfRows; ++i) {
            *(matrix + i) = value;
        }
    }
    return self;
}

-(instancetype)initWithVectors: (NSArray<MSVectorND*>*) vectors {
    self = [self initWithRows:[[vectors objectAtIndex:0] getDimension] columns:(MSMATRIX_ASSOCIATED_INT_TYPE)[vectors count]];
    if(self){
        for (MSMATRIX_ASSOCIATED_INT_TYPE i=MSMATRIX_MINIMAL_INDEX; i<[vectors count]; ++i) {
            for (MSMATRIX_ASSOCIATED_INT_TYPE j=MSMATRIX_MINIMAL_INDEX; j<[[vectors objectAtIndex:i] getDimension]; ++j) {
                *(matrix + i*amountOfRows + j) = [[vectors objectAtIndex:i] valueAtIndex:j];
            }
        }
    }
    return self;
}

-(instancetype)initWithIdentityMatrix: (MSMATRIX_ASSOCIATED_INT_TYPE const) dimension{
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
    for(MSMATRIX_ASSOCIATED_INT_TYPE i=MSMATRIX_MINIMAL_INDEX; i < self->amountOfColumns * self->amountOfRows; ++i) {
        *(self->matrix + i) *= scalar;
    }
}
-(MSMATRIX_ASSOCIATED_TYPE*)matrixAsArray{
    return self->matrix;
}
-(MSVectorND*)multiplyByColumnVector: (MSVectorND*)vector{
    MSMATRIX_ASSOCIATED_TYPE result[amountOfColumns];
    
    for(MSMATRIX_ASSOCIATED_INT_TYPE outerIterator = MSMATRIX_MINIMAL_INDEX; outerIterator < self->amountOfRows; ++outerIterator){
        MSMATRIX_ASSOCIATED_TYPE sum = MSMATRIX_ZERO_VALUE;
        for(MSMATRIX_ASSOCIATED_INT_TYPE innerIterator = MSMATRIX_MINIMAL_INDEX; innerIterator < self->amountOfColumns; ++innerIterator){
            sum += *(matrix + self->amountOfRows*innerIterator + outerIterator) * *([vector getArrayStyleVector] + innerIterator);
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
-(MSMatrixND*)safeMultiplyByMatrix: (MSMatrixND*)otherMatrix{
    if(amountOfColumns != otherMatrix->amountOfRows){
        [NSException raise:@"Cannot multiply" format:@"Amount of columns in first matrix is not matching amount of rows in second"];
    }
    return [self multiplyByMatrix:otherMatrix];
}
+(instancetype)identityMatrix:(MSMATRIX_ASSOCIATED_INT_TYPE const) dimension{
    return [[MSMatrixND alloc] initWithIdentityMatrix:dimension];
}

-(MSMatrixND*)multiplyByMatrix: (MSMatrixND*)otherMatrix{
    MSMatrixND* resultMatrix = [[MSMatrixND alloc] initWithRows:self->amountOfRows columns:otherMatrix->amountOfColumns];
    for(MSMATRIX_ASSOCIATED_INT_TYPE outerIterator = MSMATRIX_MINIMAL_INDEX; outerIterator < self->amountOfRows; ++outerIterator) {
        for (MSMATRIX_ASSOCIATED_INT_TYPE innerIterator = MSMATRIX_MINIMAL_INDEX; innerIterator < self->amountOfColumns; ++innerIterator) {
            MSMATRIX_ASSOCIATED_TYPE sum = MSMATRIX_ZERO_VALUE;
            for (MSMATRIX_ASSOCIATED_INT_TYPE i = MSMATRIX_MINIMAL_INDEX; i < amountOfColumns; ++i) {
                sum += *(self->matrix + amountOfRows*i + outerIterator) * *(otherMatrix->matrix + amountOfRows*innerIterator + i);
            }
            [resultMatrix setValueAtRowIndex:outerIterator andColumnIndex:innerIterator value:sum];
        }
    }
    return resultMatrix;
}

-(BOOL)isEqualToMatrix: (MSMatrixND*) secondMatrix{
    return [self isEqualToMatrix:secondMatrix withPrecision: MSMATRIX_ZERO_VALUE];
}

-(BOOL)isEqualToMatrix: (MSMatrixND*) secondMatrix withPrecision: (MSMATRIX_ASSOCIATED_TYPE) accuracy{
    for (int i=MSMATRIX_MINIMAL_INDEX; i<(self->amountOfColumns * self->amountOfRows); ++i){
        MSMATRIX_ASSOCIATED_TYPE difference = (self->matrix[i] - secondMatrix->matrix[i]) * (self->matrix[i] - secondMatrix->matrix[i]);
        if(difference > (accuracy*accuracy)){
            return false;
        }
    }
    return true;
}
-(void)safeSetValueAtRowIndex: (MSMATRIX_ASSOCIATED_INT_TYPE) row andColumnIndex: (MSMATRIX_ASSOCIATED_INT_TYPE) column value: (MSMATRIX_ASSOCIATED_TYPE) value {
    //check rows as well
    // TODO
    if(column<MSMATRIX_MINIMAL_INDEX || column>=amountOfColumns){
        [NSException raise:@"Index out of bounds!" format:@"Wanted column with index %i, mat has only %i",column,amountOfColumns];
    }
    [self setValueAtRowIndex:row andColumnIndex:column value:value];
}
-(void)setValueAtRowIndex: (MSMATRIX_ASSOCIATED_INT_TYPE) row andColumnIndex: (int) column value: (MSMATRIX_ASSOCIATED_TYPE) value {
    *(self->matrix + self->amountOfRows * column + row) = value;
}
-(MSMATRIX_ASSOCIATED_INT_TYPE)getAmountOfColumns{
    return self->amountOfColumns;
}
-(MSMATRIX_ASSOCIATED_INT_TYPE)getAmountOfRows{
    return self->amountOfRows;
}
-(void)dealloc{
    free(self->matrix);
}
-(MSMATRIX_ASSOCIATED_TYPE)getValueAtRowIndex:(MSMATRIX_ASSOCIATED_INT_TYPE) row andColumnIndex: (MSMATRIX_ASSOCIATED_INT_TYPE) column {
    return *(self->matrix + self->amountOfRows * column + row);
}
@end
