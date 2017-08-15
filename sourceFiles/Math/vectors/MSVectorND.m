//
//  MSVectorND.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSVectorND.h"

@implementation MSVectorND

+(instancetype)onesVector: (unsigned int const)dimension{
    MSVectorND* vectorToReturn = [[MSVectorND alloc] initVecWithDimension:dimension];
    for(int i=0; i<dimension; ++i){
        [vectorToReturn setValueAtIdenx:i value:1.0f];
    }
    return vectorToReturn;
}

-(instancetype)initVecWithDimension: (unsigned int const) dim {
    self = [super init];
    if (self) {
        self->dimension = dim;
        self->components = (float*)malloc(dim*sizeof(float));
    }
    return self;
}

-(instancetype)initWithComponents: (unsigned int const) dim, ...{
    va_list listPointer;
    va_start(listPointer, dim);
    self->dimension=dim;
    self->components=(float*)malloc(dim*sizeof(float));
    for(int i=0; i<dim; ++i){
        *(self->components+i)=(float)va_arg(listPointer, double);
    }
    va_end(listPointer);
    return self;
}

-(instancetype)initWithArrayOfComponents: (unsigned int const) dim components: (float const * const) array{
    self=[super init];
    if(self){
        self->dimension=dim;
        self->components=(float*)malloc(dimension*sizeof(float));
        for(int i=0; i<dimension; ++i){
            *(components+i)=*(array+i);
        }
    }
    return self;
}

-(instancetype)initWithVector: (MSVectorND const* const) vec{
    self=[self initWithArrayOfComponents:vec->dimension components:vec->components];
    return self;
}

-(void)add: (MSVectorND const* const) vec{
    int i=0;
    while(i<dimension){
        *(components+i)+=*(vec->components+i);
        i+=1;
    }
}

-(void)safeAdd: (MSVectorND const* const) vec{
    [self matchDimensions:vec];
    [self add:vec];
}

-(void)subtract: (MSVectorND const* const) vec{
    for(int i=0; i<dimension; ++i){
        *(components+i)-=*(vec->components+i);
    }
}

-(void)safeSubtract: (MSVectorND const* const) vec{
    [self matchDimensions:vec];
    [self subtract:vec];
}

-(float)length{
    return sqrtf([self lengthSquared]);
}

-(float)lengthSquared{
    return [self dotProduct:self];
}

-(float)dotProduct: (MSVectorND const*) vec{
    float sum=0;
    for(int i=0; i<dimension; ++i){
        sum+=*(components+i)**(vec->components+i);
    }
    return sum;
}

-(float)safeDotProduct: (MSVectorND const*) vec{
    [self matchDimensions:vec];
    return [self dotProduct:vec];
}

-(void)multiplyByScalar: (float const) scalar{
    int i=0;
    while(i<dimension){
        *(components+i)*=scalar;
        i+=1;
    }
}

-(instancetype)initZeroVecWithDimension: (unsigned int const) dim{
    float arrayToPass[dim];
    for(int i=0;i<dim;i++){
        arrayToPass[i]=0.0f;
    }
    self=[self initWithArrayOfComponents:dim components:arrayToPass];
    return self;
}

-(void)matchSpecificDimensions: (MSVectorND const *) vec dim: (unsigned int) dim {
    if(!((vec->dimension==self->dimension)&&(vec->dimension==dim))){
        [MSMathDimensionMismatchException raise:@"Dimensions are different" format:@"self was %i and argument was %i", dimension,vec->dimension];
    }
}

-(void)matchDimensions: (MSVectorND const *) vec{
    [self matchSpecificDimensions:vec dim:self->dimension];
}

-(instancetype)initWithZerosExceptIndex: (unsigned int const) index number:(float const) num dimensionOfVector: (unsigned int const) dim{
    if(index>=dim){
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

-(float)valueAtIndex:(unsigned int const)index{
    return *(components+index);
}

-(float)safeValueAtIndex:(unsigned int const)index{
    [self checkIndexBound:index];
    return [self valueAtIndex:index];
}

-(float const*)getArrayStyleVector{
    return self->components;
}

-(void)setValueAtIdenx:(unsigned int const)index value: (float)val{
    *(components+index)=val;
}

-(void)safeSetValueAtIdenx:(unsigned int const)index value: (float)val{
    [self checkIndexBound:index];
    [self setValueAtIdenx:index value:val];
}

-(void)checkIndexBound: (int) index {
    if(index>=dimension || index<0){
        [MSMathIndexOutOfBounds raise:@"Index out of bounds!" format:@"Wanted index %i, vec is only %i size",index,dimension];
    }
}

-(BOOL)safeIsEqualToVector: (MSVectorND*) vec{
    return [self safeIsEqualToVector:vec withMaxDifference:0.0];
}

-(BOOL)safeIsEqualToVector: (MSVectorND*) vec withMaxDifference: (float) difference{
    [self matchDimensions:vec];
    return [self isEqualToVector:vec withMaxDifference:difference];
}

-(BOOL)isEqualToVector: (MSVectorND*) vec{
    return [self isEqualToVector: vec withMaxDifference: 0.0];
}

-(BOOL)isEqualToVector: (MSVectorND*) vec withMaxDifference: (float) difference{
    for(int i=0; i<self->dimension; ++i){
        float vectorDifference = *(self->components+i) - *(vec->components+i);
        if (vectorDifference*vectorDifference > difference*difference){
            return false;
        }
    }
    return true;
}

-(MSVectorND*)newVectorFromAddition: (MSVectorND const * const) vec{
    MSVectorND* vectorToReturn = [[MSVectorND alloc] initWithVector:self];
    [vectorToReturn add:vec];
    return vectorToReturn;
    
}

-(MSVectorND*)newVectorFromSafeAddition: (MSVectorND const * const) vec{
    [self matchDimensions:vec];
    return [self newVectorFromAddition:vec];
}

-(MSVectorND*)newVectorFromSubtraction: (MSVectorND const * const) vec{
    MSVectorND* vectorToReturn = [[MSVectorND alloc] initWithVector:self];
    [vectorToReturn subtract:vec];
    return vectorToReturn;
}

-(MSVectorND*)newVectorFromSafeSubtraction: (MSVectorND const * const) vec{
    [self matchDimensions:vec];
    return [self newVectorFromSubtraction:vec];
}
-(MSVectorND*)crossProduct: (MSVectorND*)vector{
    MSVectorND* result = [[MSVectorND alloc] initVecWithDimension:3];
    *(result->components) = *(self->components+1)**(vector->components+2)-*(self->components+2)**(vector->components+1);
    *(result->components+1) = *(self->components+2)**(vector->components)-*(self->components)**(vector->components+2);
    *(result->components+2) = *(self->components)**(vector->components+1)-*(self->components+1)**(vector->components);
    return result;
}
-(MSVectorND*)safeCrossProduct: (MSVectorND*)vector{
    [self matchSpecificDimensions:vector dim:3];
    return [self crossProduct:vector];
}
-(MSVectorND*)multiplyByMatrix: (MSMatrixND*) matrix{
    [NSException raise:@"Not implemented yet" format:@""];
    return nil;
}
-(MSVectorND*)safeMultiplyByMatrix: (MSMatrixND*) matrix{
    return nil;
}
-(void)dealloc{
    free (self->components);
}

@end
