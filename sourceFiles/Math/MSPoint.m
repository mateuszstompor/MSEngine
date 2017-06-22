//
//  MSPoint.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPoint.h"


@implementation MSPoint
-(instancetype)initWithDimension: (int)dim{
    self=[super init];
    if(self){
        self->components=(float*)malloc(dim*sizeof(float));
        for(int i=0;i<dim;i++){
            *(components+i)=0;
        }
        self->dimension=dim;
    }
    return self;
}

-(void)checkIndexBound:(int)index{
    if(index>=dimension || index<0){
        [NSException raise:@"Index out of bounds!"
                     format:@"Wanted index %i, point has only %i",
                     index,dimension];
    }
}
-(float)getComponent: (int)index{
    [self checkIndexBound:index];
    return *(components+index);
}
-(void)setComponent: (int)index value:(float)val{
    [self checkIndexBound:index];
    *(components+index)=val;
}
-(void)printPoint{
    for(int i=0; i<dimension;i++){
        printf("%f ",*(components+i));
    }
    printf("\n");
    fflush(stdout);
}
-(instancetype)initWithComponents: (int)dim,...{
    self=[self initWithDimension:dim];
    va_list listOfComponents;
    va_start(listOfComponents, dim);
    for(int i=0; i<dim; i++){
        *(components+i)=(float)va_arg(listOfComponents, double);
    }
    va_end(listOfComponents);
    return self;
}
-(instancetype)init3DimPointWithX: (float)x y: (float)y z:(float)z{
    self=[self initWithComponents:3, x, y, z];
    return self;
}
-(instancetype)init2DimPointWithX: (float)x y: (float)y{
    self = [self initWithComponents:2,x,y];
    return self;
}
-(int)getDimension{
    return self->dimension;
}
-(void)dealloc{
    free(self->components);
}
-(float*)getComponents{
    return self->components;
}
@end
