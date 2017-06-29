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

-(instancetype)initWithModel: (NSArray<MSModelFraction*>*)md{
    self=[super initWithModel:md];
    if(self){
        color=[MSVectorND onesVector:3];
    }
    return self;
}

@end
