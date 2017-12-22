//
//  ViewController.m
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 02/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "RenderViewController.h"
#import "MSEngineTestApp-Swift.h"
#import "GyroHandler.h"
#import "TouchHandler.h"

@implementation RenderViewController
- (IBAction)segmentedControlValueDidChange:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex] == 0) {
        [(RenderView*)self.view setRotationHandler:[[TouchHandler alloc] initOn:self.view frame:CGRectMake([[UIScreen mainScreen] bounds].size.width-50-128, [[UIScreen mainScreen] bounds].size.height-50-128, 128, 128)]];
    } else {
        [(RenderView*)self.view setRotationHandler:[[GyroHandler alloc] init] ];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self->_fpsMeter setText:@""];
    // Do any additional setup after loading the view.
    RenderView* renderView = (RenderView*)self.view;
    renderView.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    
    // Configure renderbuffers created by the view
    renderView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    renderView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    renderView.drawableStencilFormat = GLKViewDrawableStencilFormat8;
    renderView->parent = self;
    renderView->labelToUpdate = self->_fpsMeter;
    // Enable multisampling
    self.preferredFramesPerSecond = 60;
    //renderView.drawableMultisample = GLKViewDrawableMultisample4X;
    self->_translationJoy.delegate = self;
    [renderView setUp];
}

- (void)joyPositionDidChangedWithSender:(JoystickView * _Nonnull)sender{
    RenderView* renderView = (RenderView*)self.view;
    renderView->translation = sender.currentPosition;
}
- (void)joyTouchRecognitionDidEndWithSender:(JoystickView * _Nonnull)sender{
    RenderView* renderView = (RenderView*)self.view;
    renderView->translation = CGPointMake(0, 0);
}

@end
