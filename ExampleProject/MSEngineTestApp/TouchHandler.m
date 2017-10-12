//
//  TouchHandler.m
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 12/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "TouchHandler.h"
#import "MSEngineTestApp-Swift.h"

@interface TouchHandler ()  <JoystickEventHandler>
@end

@implementation TouchHandler
{
    float rotationFraction;
    JoystickView* view;
    CGPoint currentJoyPosition;
}
-(instancetype)initOn: (UIView*) parentView frame: (CGRect) frame {
    self = [super init];
    if(self) {
        self->view = [[JoystickView alloc] initWithFrame:frame];
        [parentView addSubview:self->view];
        [parentView bringSubviewToFront:self->view];
        [self->view setBackgroundColor:[UIColor whiteColor]];
        self->rotationFraction = 0.008;
        (self->view).delegate = self;
    }
    return self;
}
-(void)rotate:(id<MSPositionedObject>) object {
    [[object getTransformation] rotateByAngleInRadians:-currentJoyPosition.y*rotationFraction y:-self->currentJoyPosition.x*rotationFraction z:0.0];
}

- (void)joyPositionDidChangedWithSender:(JoystickView * _Nonnull)sender{
    self->currentJoyPosition = sender.currentPosition;
}
- (void)joyTouchRecognitionDidEndWithSender:(JoystickView * _Nonnull)sender{
    self->currentJoyPosition = CGPointMake(0, 0);
}
-(void)dealloc {
    [self->view removeFromSuperview];
    self->view = nil;
}
@end
