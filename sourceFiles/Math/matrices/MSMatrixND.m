//
//  MSMatrixND.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSMatrixND.h"

@implementation MSMatrixND
{
    
}
-(instancetype)initWithVectors:(int const)numberOfColumns, ... {
    self=[super init];
    if(self){
        self->matrix=[[NSMutableArray alloc] init];
        self->amountOfColumns=numberOfColumns;
        va_list listOfColumnsVecs;
        va_start(listOfColumnsVecs, numberOfColumns);
        [matrix addObject:[[MSVectorND alloc] initWithVector:(MSVectorND*)va_arg(listOfColumnsVecs, MSVectorND*)]];
        self->amountOfRows=[(MSVectorND*)[matrix objectAtIndex:0] getDimension];
        for(int i=0;i<numberOfColumns-1;i++){
            MSVectorND* objToAdd=(MSVectorND*)va_arg(listOfColumnsVecs, MSVectorND*);
            [(MSVectorND*)[matrix objectAtIndex:0] checkDimensions:objToAdd];
            [matrix addObject:[[MSVectorND alloc] initWithVector:objToAdd]];
        }
        va_end(listOfColumnsVecs);
        if([matrix count]!=amountOfColumns){
            [NSException raise:@"Too few columns" format:@"Declared %i get get %lu", numberOfColumns,(unsigned long)[matrix count]];
        }
        cMatrix = nil;
        asArrayMatrix = nil;
    }
    return self;
}
-(instancetype)initWithIdentityMatrix: (int const) dimension{
    self=[self initWithVectors:1,[[MSVectorND alloc]initWithZerosExceptIndex:0 number:1.0f dimensionOfVector:dimension]];
    if(self){
        for(int i=1; i<dimension;i++){
            [self extendMatrixAboutColumn:[[MSVectorND alloc]initWithZerosExceptIndex:i number:1.0f dimensionOfVector:dimension]];
        }
    }
    return self;
}
-(instancetype)initWithMatrix: (MSMatrixND const * const) matrixToCopy{
    unsigned long matrixDimension=[matrixToCopy->matrix count];
    self=[self initWithVectors:1,(MSVectorND*)[matrixToCopy->matrix objectAtIndex:0]];
    if(self){
        for(int i=1;i<matrixDimension;i++){
            [self extendMatrixAboutColumn:(MSVectorND*)[matrixToCopy->matrix objectAtIndex:i]];
        }
    }
    return self;
}
-(void)extendMatrixAboutColumn:(MSVectorND const* const)vec{
    [(MSVectorND*)[matrix objectAtIndex:0] checkDimensions:vec];
    [matrix addObject:[[MSVectorND alloc] initWithVector:vec]];
    self->amountOfColumns+=1;
}
-(void)multiplyByScalar: (float)scalar{
    for(MSVectorND* vec in matrix){
        [vec multiplyByScalar:scalar];
    }
}
-(void)printMatrix{
    for(int rowIterator=0;rowIterator<amountOfRows;rowIterator++){
        for(int columntIterator=0;columntIterator<amountOfColumns;columntIterator++){
            printf("%f ", [(MSVectorND*)[matrix objectAtIndex:columntIterator] valueAtIndex:rowIterator]);
        }
        printf("\n");
        fflush(stdout);
    }
    printf("Amount of columns: %d\n", amountOfColumns);
    printf("Amount of rows: %d\n", amountOfRows);
    fflush(stdout);
}
-(float**)getColumnMajorArrayStyleMatrix{
    float** cStyleMatrix = (float**)malloc(amountOfColumns*sizeof(float*));
    for(int i=0;i<amountOfColumns;i++){
        *(cStyleMatrix+i)=[(MSVectorND*)[matrix objectAtIndex:i] getArrayStyleVector];
    }
    free(cMatrix);
    cMatrix = cStyleMatrix;
    return cStyleMatrix;
}
-(float*)matrixAsArray{
    int amountOfElements=amountOfColumns*amountOfRows;
    float* matrixToReturn = (float*)malloc(amountOfElements*sizeof(float));
    int j=0;
    for(int i=0;i<amountOfElements;i++){
        if(i%amountOfRows==0 && i!=0){
            j++;
        }
        *(matrixToReturn+i)=[[matrix objectAtIndex:j] valueAtIndex:(i%amountOfRows)];
    }
    free(asArrayMatrix);
    asArrayMatrix=matrixToReturn;
    return matrixToReturn;
}
-(MSVectorND*)multiplyByColumnVector: (MSVectorND*)vector{
    if(amountOfRows==1){
        [NSException raise:@"It would be dot product!" format:@"Unsupported operation"];
    }
    if([vector getDimension]!=amountOfColumns){
        [NSException raise:@"Cannot multiply" format:@"Amount of columns in array was %i and in vec %i", amountOfColumns,[vector getDimension]];
    }
    float result[amountOfColumns];
    for(int outerIterator=0; outerIterator<amountOfRows;outerIterator++){
        float sum=0.0f;
        for(int innerIterator=0; innerIterator<amountOfColumns;innerIterator++){
            sum+=[(MSVectorND*)[matrix objectAtIndex:innerIterator] valueAtIndex:outerIterator]*[vector valueAtIndex:innerIterator];
        }
        result[outerIterator]=sum;
    }
    return [[MSVectorND alloc] initWithArrayOfComponents:amountOfRows components:result];
}
+(instancetype)identityMatrix:(int const)dimension{
    return [[MSMatrixND alloc]initWithIdentityMatrix:dimension];
}
-(MSMatrixND*)multiplyByMatrix: (MSMatrixND*)otherMatrix{
    if(amountOfColumns!=otherMatrix->amountOfRows){
        [NSException raise:@"Cannot multiply" format:@"Amount of columns in first matrix is not matching amount of rows in second"];
    }
    MSMatrixND* resultMatrix;
    for(int secondMatrixColumnIter=0;secondMatrixColumnIter<otherMatrix->amountOfColumns;secondMatrixColumnIter++){
        float result[amountOfRows];
        for(int firstMatrixRowIter=0;firstMatrixRowIter<amountOfRows;firstMatrixRowIter++){
            result[firstMatrixRowIter]=0;
            for(int i=0;i<amountOfColumns;i++){
                float leftArElement=[(MSVectorND*)[matrix objectAtIndex:i] valueAtIndex:firstMatrixRowIter];
                float rightArElement=[(MSVectorND*)[otherMatrix->matrix objectAtIndex:secondMatrixColumnIter] valueAtIndex:i];
                result[firstMatrixRowIter]+=leftArElement*rightArElement;
            }
        }
        if(secondMatrixColumnIter==0){
            resultMatrix=[[MSMatrixND alloc] initWithVectors:1,[[MSVectorND alloc] initWithArrayOfComponents:amountOfRows components:result]];
        }
        else{
            [resultMatrix extendMatrixAboutColumn:[[MSVectorND alloc] initWithArrayOfComponents:amountOfRows components:result]];
        }
    }
    return resultMatrix;
}
-(void)setValueAtRowIndex:(int) rowI andColumnIndex: (int) columnI value:(float)val{
    if(columnI<0 || columnI>=amountOfColumns){
        [NSException raise:@"Index out of bounds!" format:@"Wanted column with index %i, mat has only %i",columnI,amountOfColumns];
    }
    [(MSVectorND*)[matrix objectAtIndex:columnI] setValueAtIdenx:rowI value:val];
}
-(int)getAmountOfColumns{
    return self->amountOfColumns;
}
-(int)getAmountOfRows{
    return self->amountOfRows;
}
-(void)dealloc{
    free(cMatrix);
    free(asArrayMatrix);
}
@end
