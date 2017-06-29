//
//  MSRender.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSWorld.h"


#define AMBIENT_SETTING 1
#define DIFFUSE_SETTING 2
#define SPECULAR_SETTING 4
#define ONLY_CONTOUR_SETTING 8


#ifndef MSRENDER_H
#define MSRENDER_H

@protocol MSRender

-(void)setBehavioureforeEachDraw: (void (^_Nullable)(void))block;
-(void)drawScene;
-(void)setBehaviourAfterEachDraw: (void (^_Nullable)(void))block;

//-(int)getSettings;
//
//-(void)renderAmbient: (BOOL) value;
//-(void)renderSpecular: (BOOL) value;
//-(void)renderDiffuse: (BOOL) value;
//-(void)renderOnlyContour: (BOOL) value;

@end

#endif
