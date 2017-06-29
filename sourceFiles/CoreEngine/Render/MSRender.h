//
//  MSRender.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSWorld.h"
#import "GraphicsConstants.h"



#ifndef MSRENDER_H
#define MSRENDER_H

@protocol MSRender

@property (atomic) int settings;

-(void)setBehavioureforeEachDraw: (void (^_Nullable)(void))block;
-(void)drawScene;
-(void)setBehaviourAfterEachDraw: (void (^_Nullable)(void))block;

@end

#endif
