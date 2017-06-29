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
#import "MSLightSource.h"
#import "MSMaterialStore.h"
#import "MSPositionedObject.h"



#ifndef MSWORLD_H
#define MSWORLD_H
@interface MSWorld : NSObject
{
    id<MSPositionedObject> camera;
    NSMutableArray<MSPuppet*>* objectsInWorld;
    NSMutableArray<MSLightSource*>* lightSources;
    MSMaterialStore* materialsInWorld;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithMaterials: (MSMaterialStore*)store;

-(void)translateCameraX: (float)x y:(float)y z:(float)z;
-(void)rotateCameraX: (float)x y:(float)y z:(float)z;

-(id<MSPositionedObject>)getCamera;
-(NSMutableArray<MSPuppet*>*)getModels;

-(void)addModelToWorld: (MSPuppet*)pup;
-(NSMutableArray<MSLightSource*>*)getLightSources;
-(void)addLightSourceToWorld: (MSLightSource*)lght;

-(void)translatelight: (MSLightSource*)light x: (float)x y:(float)y z:(float)z;

-(MSMaterialStore*)getAvailavleMaterials;
@end
#endif
