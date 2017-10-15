//
//  MSLight.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 10/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSVectorND.h"

#ifndef MSLight_h
#define MSLight_h

@protocol MSLight
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithPower: (float) power color: (MSVector3D*) color;
- (instancetype)initWithPower:(float)power color:(MSVector3D *)color isOn: (BOOL) isOn;
-(void)setColor: (MSVector3D*) color;
-(MSVector3D*)getColor;
-(BOOL)isOn;
-(void)lights: (BOOL) isOn;
-(float)getPower;
-(void)setPower: (float) power;
@end

#endif
