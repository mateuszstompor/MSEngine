//
//  RenderView.h
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 02/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <iMSGraphicsEngine/iMSGraphicsEngine.h>
#import "RenderViewController.h"

#ifndef m
#define m

@interface RenderView : GLKView

{
    @public
    CGPoint rotation;
    CGPoint translation;
    float zTranslation;
    UILabel* labelToUpdate;
    GLKViewController* parent;
}

-(void)setUp;

@end

#endif
