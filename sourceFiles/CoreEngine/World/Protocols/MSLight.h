//
//  MSLight.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 10/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#ifndef MSLight_h
#define MSLight_h

@protocol MSLight
-(void)setColor: (MSVector3D*) color;
-(void)getColor: (MSVector3D*) color;
-(BOOL)isOn;
-(void)turnON;
-(void)turnOFF;
-(float)getPower;
-(float)setPower;
@end

#endif
