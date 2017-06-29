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

@interface MSLightSource : MSPuppet

@property (atomic) MSVector3D* color;

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithModel: (NSArray<MSModelFraction*>*)md;

@end
