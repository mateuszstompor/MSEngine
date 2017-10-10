//
//  MSLightSource.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 03/05/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPointLight.h"

@implementation MSPointLight
{
    MSModelTransform* transformation;
}
@synthesize color;
@synthesize power;


-(instancetype _Nullable)initWithModel: (NSArray<MSModelFraction*>* _Nonnull)mod
                                          color: (MSVector3D*) col power: (float)pw{
    self=[super initWithModel: mod];
    if(self){
        self->color=col;
        self->power=pw;
    }
    return self;
}

@end
