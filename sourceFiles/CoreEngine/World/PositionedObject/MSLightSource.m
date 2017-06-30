//
//  MSLightSource.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 03/05/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSLightSource.h"

@implementation MSLightSource

@synthesize color;

-(instancetype)initWithModel: (NSArray<MSModelFraction*>*)md color: (MSVector3D*) c{
    self=[super initWithModel:md];
    if(self){
        color=c;
    }
    return self;
}

@end
