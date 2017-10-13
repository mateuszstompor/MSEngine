//
//  GyroHandler.m
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 13/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "GyroHandler.h"
#import "Rotator.h"
#import <CoreMotion/CoreMotion.h>

@interface GyroHandler ()
{
    CMMotionManager* motionManager;
    NSOperationQueue* queue;
}

@property (atomic) float pitch;
@property (atomic) float roll;
@property (atomic) float yaw;

@end

@implementation GyroHandler

@synthesize pitch=pitch;
@synthesize roll=roll;
@synthesize yaw=yaw;

-(instancetype)init {
    self = [super init];
    if(self){
        self->motionManager = [[CMMotionManager alloc] init];
        self->queue = [[NSOperationQueue alloc] init];
        self->pitch = 0;
        self->roll = 0;
        self->yaw = 0;
        if (motionManager.isDeviceMotionAvailable) {
            [motionManager setDeviceMotionUpdateInterval:0.01];
            [motionManager startDeviceMotionUpdatesToQueue:queue withHandler:^
             (CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
                if (motion) {
                    __weak GyroHandler* handler = self;
                    [handler setYaw:[motion attitude].yaw];
                    [handler setRoll:[motion attitude].roll];
                    [handler setPitch:[motion attitude].pitch];
                }
            }];
        }
    }
    return self;
}
-(void)rotate:(id<MSPositionedObject>) object {
    [[object getTransformation] setRotationInRadians:-roll+M_PI_2 y:yaw z:pitch];
}
@end
