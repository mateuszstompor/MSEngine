//
//  RenderView.h
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 02/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <iMSGraphicsEngine/iMSGraphicsEngine.h>



@interface RenderView : GLKView

{
    MSWorld* world;
    id<MSRender> renderer;
}

-(void)setUp;

@end
