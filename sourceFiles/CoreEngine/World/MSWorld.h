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
#import "MSLightSource.h"
#import "MSMaterialStore.h"


@interface MSWorld : NSObject
{
    MSCamera* camera;
    NSMutableArray<MSPuppet*>* objectsInWorld;
    NSMutableArray<MSLightSource*>* lightSources;
    MSMaterialStore* materialsInWorld;
}
-(instancetype)init;
-(void)translateCameraX: (float)x y:(float)y z:(float)z;
-(void)rotateCameraX: (float)x y:(float)y z:(float)z;
-(MSCamera*)getCamera;
-(NSMutableArray<MSPuppet*>*)getModels;
-(void)addModelToWorld: (MSPuppet*)pup;
-(NSMutableArray<MSLightSource*>*)getLightSources;
-(void)addLightSourceToWorld: (MSLightSource*)lght;
-(void)translatelight: (MSLightSource*)light x: (float)x y:(float)y z:(float)z;
@end
