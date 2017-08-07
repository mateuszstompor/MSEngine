//
//  ViewController.m
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 02/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

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
    renderView->labelToUpdate = self->_fpsMeter;
    // Enable multisampling
    self.preferredFramesPerSecond = 30;
    renderView.drawableMultisample = GLKViewDrawableMultisample4X;
    self->_rotationJoy.delegate = self;
    self->_translationJoy.delegate = self;
    [renderView setUp];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)joyPositionDidChangedWithSender:(JoystickView * _Nonnull)sender{
    RenderView* renderView = (RenderView*)self.view;
    if (sender == self.translationJoy){
        renderView->translation = sender.currentPosition;
    }else if (sender == self.rotationJoy) {
        renderView->rotation = sender.currentPosition;
    }
}
- (void)joyTouchRecognitionDidEndWithSender:(JoystickView * _Nonnull)sender{
    RenderView* renderView = (RenderView*)self.view;
    if (sender == self.translationJoy){
        renderView->translation = CGPointMake(0, 0);
    }else if (sender == self.rotationJoy) {
        renderView->rotation = CGPointMake(0, 0);
    }
}
@end
