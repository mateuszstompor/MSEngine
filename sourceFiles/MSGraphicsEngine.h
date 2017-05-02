//  MSGraphicsEngine.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 28/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.

#import <Foundation/Foundation.h>
#import "MSRender.h"
#import "MSWorld.h"


#ifndef MSGRAPHICSENGINE_H
#define MSGRAPHICSENGINE_H
@interface MSGraphicsEngine : NSObject
{
    MSWorld* world;
    MSRender* renderer;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithShader: (GLuint) program;
-(void)runRenderEngine;
-(void)translateCameraX: (float) x y: (float)y z:(float)z;
@end
#endif
