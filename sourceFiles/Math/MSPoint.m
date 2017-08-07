//
//  MSPoint.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPoint.h"
#import <stdio.h>
#import "MSMathException.h"

@implementation MSPoint

-(instancetype)initWithDimension: (unsigned int const)dim{
    self=[super init];
    if(self){
        self->components=(float*)malloc(dim*sizeof(float));
        self->dimension=dim;
    }
    return self;
}

-(instancetype)initZeroPointWithDimension: (unsigned int const)dim{
    self = [self initWithDimension:dim];
    if(self){
        for(int i=0; i<dim; ++i){
            *(components+i)=0;
        }
    }
    return self;
}

-(void)checkIndexBound:(unsigned int const)index{
    if(index>=dimension){
        [MSMathIndexOutOfBounds raise:@"Index out of bounds!"
                     format:@"Wanted index %i, point has only %i",
                     index, dimension];
    }
}

-(float)getComponent: (unsigned int const)index{
    return *(components+index);
}

-(float const)safeGetComponent: (unsigned int const)index{
    [self checkIndexBound:index];
    return [self getComponent:index];
}

-(void)setComponent: (unsigned int const)index value:(float const)val{
    *(components+index)=val;
}

-(void)safeSetComponent: (unsigned int const)index value:(float const)val{
    [self checkIndexBound:index];
    [self setComponent:index value:val];
}

-(instancetype)initWithComponents: (unsigned int const)dim,...{
    self=[self initWithDimension:dim];
    va_list listOfComponents;
    va_start(listOfComponents, dim);
    for(int i=0; i<dim; ++i){
        *(components+i)=(float)va_arg(listOfComponents, double);
    }
    va_end(listOfComponents);
    return self;
}

-(instancetype)init3DimPointWithX: (float const)x y: (float const)y z:(float const)z{
    self=[self initWithComponents:3, x, y, z];
    return self;
}

-(instancetype)init2DimPointWithX: (float const)x y: (float const)y{
    self = [self initWithComponents:2, x, y];
    return self;
}

-(unsigned int const)getDimension{
    return self->dimension;
}

-(void)dealloc{
    free(self->components);
}

-(float const *)getComponents{
    return self->components;
}

@end
