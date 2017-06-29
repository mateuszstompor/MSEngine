//
//  MSpuppet.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 24/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPuppet.h"


@implementation MSPuppet

@synthesize scale;
@synthesize rotation;
@synthesize translation;


-(instancetype)initWithScale: (MSMatrix4D*)scaleM rotation: (MSMatrix4D*)rotationM translation:(MSMatrix4D*)trM model: (NSArray<MSModelFraction*>*)mod{
    if(self){
        self->scale=scaleM;
        self->rotation=rotationM;
        self->translation=trM;
        self->model=mod;
    }
    return self;
}
-(NSArray<MSModelFraction*>*)getModelComponents{
    return model;
}
-(instancetype)initWithModel: (NSArray<MSModelFraction*>*)md{
    self=[self initWithScale:[MSMatrixND identityMatrix:4] rotation:[MSMatrixND identityMatrix:4] translation:[MSMatrixND identityMatrix:4] model:md];
    return self;
}
-(void)translateBy: (MSMatrixND*) tr{
    self->translation=[tr multiplyByMatrix:translation];
}
-(void)rotateBy: (MSMatrixND*) rot{
    self->rotation=[rot multiplyByMatrix:rotation];
}
-(void)scaleBy:(MSMatrixND*) sc{
    self->scale=[sc multiplyByMatrix:self->scale];
}

@end
