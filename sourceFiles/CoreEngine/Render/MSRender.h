//
//  MSRender.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSWorld.h"
#import "MSGraphicsConstants.h"
#import <Foundation/Foundation.h>

#ifndef MSRENDER_H
#define MSRENDER_H

@interface MSRender : NSObject
{
    float lastFrameRate;
    NSDate *lastSecond;
    MSWorld* world;
}

-(instancetype)alloc NS_UNAVAILABLE;
-(void)clearFrame;
-(void)drawLights;
-(void)drawModels;
-(void)drawScene;
-(float)getCurrentFrameRate;
-(void)finishWork;
-(instancetype)initWithWorld:(MSWorld *)world;

@end

#endif
