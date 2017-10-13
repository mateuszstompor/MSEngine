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
#import "Rotator.h"

#ifndef RenderView_h
#define RenderView_h

@interface RenderView : GLKView

{
    @public
    CGPoint translation;
    UILabel* labelToUpdate;
    GLKViewController* parent;
}
-(void)setRotationHandler: (id<Rotator>) rotator;
-(void)setUp;

@end

#endif
