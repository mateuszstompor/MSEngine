//
//  MSPositionedLight.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 08/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPositionedLight.h"
#import "MSPuppet.h"

@implementation MSPositionedLight
@synthesize color;
@synthesize power;

-(MSPuppet*)getPuppet {
    return self->itsPuppet;
}
@end
