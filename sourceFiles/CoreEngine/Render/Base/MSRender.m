//
//  MSRender.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 03/09/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSRender.h"


@implementation MSRender

-(void)drawScene {
    [self countFrameRate];
    [self clearFrame];
    [self drawModels];
    [self drawLights];
}

-(float)getCurrentFrameRate {
    return self->lastFrameRate;
}

-(void)countFrameRate {
    static unsigned int amountOfFramesRendered = 0;
    NSDate *now = [NSDate date];
    NSTimeInterval executionTime = [now timeIntervalSinceDate:lastSecond];
    if(executionTime > 1.0f){
        self->lastFrameRate = amountOfFramesRendered/executionTime;
        amountOfFramesRendered=0;
        lastSecond=now;
    }
    amountOfFramesRendered+=1;
}

-(void)clearFrame {
}

-(void)drawLights {
}

-(void)drawModels {
}

@end
