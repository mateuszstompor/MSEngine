//
//  MSVectorND.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSVectorND.h"

@implementation MSVectorND
-(instancetype)initWithComponents: (int const) dim, ...{
    va_list listPointer;
    va_start(listPointer, dim);
    float* buffer=(float*)malloc(dim*sizeof(float));
    int i=0;
    while(i<dim){
        float numberToAdd=(float)va_arg(listPointer, double);
        if(isinf(numberToAdd)){
            [NSException raise:@"Invalid number of arguments" format:@"Too few of them"];
        }
        *(buffer+i)=numberToAdd;
        i+=1;
    }
    va_end(listPointer);
    self=[self initWithArrayOfComponents:dim components:buffer];
    free (buffer);
    return self;
}
+(instancetype)onesVector: (int)dimension{
    MSVectorND* vectorToReturn = [[MSVectorND alloc] initZeroVecWithDimension:dimension];
    for(int i=0; i<dimension; ++i){
        [vectorToReturn setValueAtIdenx:i value:1.0f];
    }
    return vectorToReturn;
}
-(instancetype)initWithArrayOfComponents: (int const) dim components: (float const * const) array{
    self=[super self];
    if(self){
        self->dimension=dim;
        self->components=(float*)malloc(dimension*sizeof(float));
        int i=0;
        while(i<dimension){
            *(components+i)=*(array+i);
            i+=1;
        }
    }
    return self;
}

-(instancetype)initWithVector: (MSVectorND const* const) vec{
    self=[self initWithArrayOfComponents:vec->dimension components:vec->components];
    return self;
}
-(void)add: (MSVectorND const* const) vec{
    [self checkDimensions:vec];
    int i=0;
    while(i<dimension){
        *(components+i)+=*(vec->components+i);
        i+=1;
    }
}
-(void)subtract: (MSVectorND const* const) vec{
    [self checkDimensions:vec];
    int i=0;
    while(i<dimension){
        *(components+i)-=*(vec->components+i);
        i+=1;
    }
}
-(float)length{
    return sqrtf([self dotProduct:self]);
}
-(float)dotProduct: (MSVectorND const* const ) vec{
    [self checkDimensions:vec];
    int i=0;
    float sum=0;
    while(i<dimension){
        sum+=*(components+i)**(vec->components+i);
        i+=1;
    }
    return sum;
}
-(void)multiplyByScalar: (float const) scalar{
    int i=0;
    while(i<dimension){
        *(components+i)*=scalar;
        i+=1;
    }
}
-(instancetype)initZeroVecWithDimension: (int const) dim{
    float arrayToPass[dim];
    for(int i=0;i<dim;i++){
        arrayToPass[i]=0.0f;
    }
    self=[self initWithArrayOfComponents:dim components:arrayToPass];
    return self;
}
-(void)checkDimensions: (MSVectorND const * const) vec{
        if(vec->dimension!=self->dimension){
            [NSException raise:@"Dimensions are different" format:@"self was %i and argument was %i", dimension,vec->dimension];
        }
}
-(instancetype)initWithZerosExceptIndex: (int) index number:(float) num dimensionOfVector: (int) dim{
    if((index>dim-1)||(index<0)){
        [NSException raise:@"Incorrect index" format:@"index was %i", index];
    }
    self=[self initZeroVecWithDimension:dim];
    if(self){
        *(components+index)=num;
    }
    return self;
}
-(int)getDimension{
    return self->dimension;
}
-(void)normalize{
    float lengthOfVec = [self length];
    for(int i=0;i<dimension;i++){
        *(components+i)/=lengthOfVec;
    }
}
-(float)valueAtIndex:(int)index{
    if((index>dimension-1)||index<0){
        [NSException raise:@"Incorrect index!" format:@"Dim of vec is %i and you want %i", dimension,index];
    }
    return *(components+index);
}
-(float*)getArrayStyleVector{
    return self->components;
}
-(void)setValueAtIdenx:(int)index value: (float)val{
    if(index>=dimension || index<0){
        [NSException raise:@"Index out of bounds!" format:@"Wanted index %i, vec is only %i size",index,dimension];
    }
    *(components+index)=val;
}
-(void)printVector{
    int i=0;
    printf("Dimension is %i\n",dimension);
    printf("Components: ");

    while(i<dimension){
        printf("%f ",*(components+i));
        i+=1;
    }
    printf("\n");
    fflush(stdout);
}
-(void)dealloc{
    free (self->components);
}
@end
