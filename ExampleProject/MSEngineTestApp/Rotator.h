//
//  Rotator.h
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 12/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import <iMSGraphicsEngine/iMSGraphicsEngine.h>

#ifndef Rotator_h
#define Rotator_h

@protocol Rotator
-(void)rotate:(id<MSPositionedObject>) object;
@end
#endif /* Rotator_h */
