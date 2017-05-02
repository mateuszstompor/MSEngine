//
//  MSPlane.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSPuppet.h"
#import "MSTransformationManager.h"
#import "MSCamera.h"
@interface MSWorld : NSObject
{
    NSMutableArray<MSPuppet*>* objectsInWorld;
    MSCamera* camera;
}
-(instancetype)init;
-(void)translateCameraX: (float)x y:(float)y z:(float)z;
-(MSCamera*)getCamera;
-(NSMutableArray<MSPuppet*>*)getModels;
-(void)addModelToWorld: (MSPuppet*)pup;
@end
