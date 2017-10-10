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
-(instancetype)init;
-(MSCamera*)getCamera;
-(void)setMaterialStore: (MSMaterialStore*) store;
-(void)setCamera: (MSCamera*) camera;
-(NSMutableArray<MSPuppet*>*)getModels;
-(void)addModelToWorld: (MSPuppet*)pup;
-(NSMutableArray<MSPointLight*>*)getLightSources;
-(void)addLightSourceToWorld: (MSPointLight*)lght;
-(MSMaterialStore*)getAvailavleMaterials;
@end
#endif
