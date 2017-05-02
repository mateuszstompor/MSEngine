//
//  MSpuppet.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 24/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPuppet.h"


@implementation MSPuppet

-(instancetype)initWithScale: (MSMatrix4D*)scaleM rotation: (MSMatrix4D*)rotationM translation:(MSMatrix4D*)trM model: (NSArray<MSModelFraction*>*)mod{
    self=[super initWithScale:scaleM rotation:rotationM translation:trM];
    if(self){
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
@end
