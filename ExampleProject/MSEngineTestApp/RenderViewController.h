//
//  ViewController.h
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 02/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//



#ifndef RenderViewController_h
#define RenderViewController_h

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "RenderView.h"

@class JoystickView;
@protocol JoystickEventHandler;

@interface RenderViewController : GLKViewController <JoystickEventHandler>

@property (weak, nonatomic) IBOutlet JoystickView *translationJoy;
@property (weak, nonatomic) IBOutlet UILabel *fpsMeter;

@end

#endif
