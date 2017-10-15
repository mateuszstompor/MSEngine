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
#import "MSLight.h"
#import "MSPositionedLight.h"

@interface MSPointLight : MSPuppet <MSPositionedLight>

-(instancetype _Nonnull)init NS_UNAVAILABLE;
-(instancetype _Nullable)initWithModel: (NSArray<MSModelFraction*>* _Nonnull)mod NS_UNAVAILABLE;
-(instancetype _Nullable)initWithModel: (NSArray<MSModelFraction*>* _Nonnull)mod
                                          color: (MSVector3D* _Nonnull) color power: (float)power;
@end
