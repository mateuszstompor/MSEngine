//
//  MSBaseLight.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 14/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSBaseLight.h"

@implementation MSBaseLight
{
    
    BOOL isOn;
    float power;
    MSVector3D* color;
}
- (MSVector3D*)getColor {
    if(isOn) {
        return self->color;
    } else {
        static MSVector3D* offLightColor = nil;
        if(offLightColor == nil) {
            offLightColor = [[MSVectorND alloc] initZeroVecWithDimension:3];
        }
        return offLightColor;
    }
}

- (float)getPower {
    return self->power;
}

- (instancetype)initWithPower:(float)power_ color:(MSVector4D *)color_ {
    return [self initWithPower:power_ color:color_ isOn:false];
}

- (BOOL)isOn {
    return self->isOn;
}

- (void)setColor:(MSVector3D *)color_ {
    self->color = color_;
}

-(void)setPower: (float) power_ {
    self->power = power_;
}

-(void)lights: (BOOL) isOn_ {
    self->isOn = isOn_;
}

- (instancetype)initWithPower:(float)power_ color:(MSVector3D *)color_ isOn:(BOOL)isOn_ {
    self = [super init];
    if(self) {
        self->power = power_;
        self->color = color_;
        self->isOn = isOn_;
    }
    return self;
}

@end
