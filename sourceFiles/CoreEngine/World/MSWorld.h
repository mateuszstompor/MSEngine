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
#import "MSPointLight.h"
#import "MSMaterialStore.h"
#import "MSPositionedObject.h"
#import "MSCamera.h"


#ifndef MSWORLD_H
#define MSWORLD_H
@interface MSWorld : NSObject
{
    MSCamera* camera;
    NSMutableArray<MSPuppet*>* objectsInWorld;
    NSMutableArray<MSPointLight*>* lightSources;
    MSMaterialStore* materialsInWorld;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithMaterials: (MSMaterialStore*)store camera: (MSCamera*)cam;
-(void)translateObject: (id<MSPositionedObject>)obj x:(float)x y:(float)y z:(float)z;
-(void)rotateObject: (id<MSPositionedObject>)obj x:(float)x y:(float)y z:(float)z;
-(MSCamera*)getCamera;
-(NSMutableArray<MSPuppet*>*)getModels;
-(void)addModelToWorld: (MSPuppet*)pup;
-(NSMutableArray<MSPointLight*>*)getLightSources;
-(void)addLightSourceToWorld: (MSPointLight*)lght;
-(MSMaterialStore*)getAvailavleMaterials;
@end
#endif
