//
//  MSLightSource.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 03/05/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPointLight.h"

@implementation MSPointLight

@synthesize color;
@synthesize power;

-(instancetype)initWithModel: (NSArray<MSModelFraction*>*) md color: (MSVector3D*) c power: (float)pw{
    self=[super initWithModel:md];
    if(self){
        self->color=c;
        self->power=pw;
    }
    return self;
}

@end
