//
//  MSpuppet.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 24/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPuppet.h"


@implementation MSPuppet

-(instancetype)initWithModel: (NSArray<MSModelFraction*>*)mod{
    if(self){
        self->model=mod;
    }
    return self;
}
-(NSArray<MSModelFraction*>*)getModelComponents{
    return model;
}

@end
