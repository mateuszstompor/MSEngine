//
//  ViewController.h
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 02/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "MSEngineTestApp-Swift.h"
#import "RenderView.h"

#ifndef ViewController_h
#define ViewController_h

@class JoystickView;
@protocol JoystickEventHandler;

@interface ViewController : GLKViewController <JoystickEventHandler>

@property (weak, nonatomic) IBOutlet JoystickView *rotationJoy;
@property (weak, nonatomic) IBOutlet JoystickView *translationJoy;
@property (weak, nonatomic) IBOutlet UILabel *fpsMeter;

@end

#endif
