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
{
    MSVector3D* color;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithScale: (MSMatrix4D*)scaleM rotation: (MSMatrix4D*)rotationM translation:(MSMatrix4D*)trM NS_UNAVAILABLE;
-(instancetype)initWithModel: (NSArray<MSModelFraction*>*)md NS_UNAVAILABLE;
-(instancetype)initWithScale: (MSMatrix4D*)scaleM rotation: (MSMatrix4D*)rotationM translation:(MSMatrix4D*)trM model: (NSArray<MSModelFraction*>*)mod NS_UNAVAILABLE;
-(instancetype)initWithModel: (NSArray<MSModelFraction*>*)md andColor:(MSVector3D*) col;
-(instancetype)initWithScale: (MSMatrix4D*)scaleM rotation: (MSMatrix4D*)rotationM translation:(MSMatrix4D*)trM model: (NSArray<MSModelFraction*>*)mod andColor:(MSVector3D*) col;
-(void)setColor: (MSVector3D*)col;
-(MSVector3D*)getColor;
@end
