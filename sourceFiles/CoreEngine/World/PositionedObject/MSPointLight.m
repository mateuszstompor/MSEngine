//
//  MSLightSource.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 03/05/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPointLight.h"
#import "MSBaseLight.h"

@implementation MSPointLight
{
    id<MSLight> light;
}
-(instancetype _Nullable)initWithModel: (NSArray<MSModelFraction*>* _Nonnull)mod
                                          color: (MSVector3D*) col power: (float)pw{
    self=[super initWithModel: mod];
    if(self){
        self->light = [[MSBaseLight alloc] initWithPower: pw color: col];
    }
    return self;
}

- (id<MSLight>)getLight {
    return self->light;
}

- (MSModelTransform *)getTransformation {
    return [[self->model objectAtIndex:0] getTransformation];
}

@end
