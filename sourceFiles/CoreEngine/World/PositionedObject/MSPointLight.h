//
//  MSLightSource.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 03/05/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSPuppet.h"
#import "MSTransformationManager.h"
#import "MSPositionedLight.h"

@interface MSPointLight : MSPuppet <MSPositionedLight>

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithModel: (NSArray<MSModelFraction*>*) model NS_UNAVAILABLE;
-(instancetype)initWithModel: (NSArray<MSModelFraction*>*) model color: (MSVector3D*) color power: (float)power;

@end
