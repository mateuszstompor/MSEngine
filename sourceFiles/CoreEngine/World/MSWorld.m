//
//  MSPlane.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSWorld.h"

@implementation MSWorld
-(instancetype)init{
    self=[super init];
    if(self){
        self->objectsInWorld=[[NSMutableArray alloc]init];
        self->lightSources=[[NSMutableArray alloc]init];
    }
    return self;
}
-(void)setCamera:(MSCamera *)cam{
    self->camera = cam;
}
-(void)setMaterialStore:(MSMaterialStore *)store {
    self->materialsInWorld = store;
}
-(MSCamera*)getCamera{
    return self->camera;
}
-(NSMutableArray<MSPointLight*>*)getLightSources{
    return lightSources;
}
-(void)addLightSourceToWorld: (MSPointLight*)lght{
    [lightSources addObject:lght];
}
-(NSMutableArray<MSPuppet*>*)getModels{
    return objectsInWorld;
}
-(void)addModelToWorld: (MSPuppet*)pup{
    [objectsInWorld addObject:pup];
}
-(MSMaterialStore*)getAvailavleMaterials{
    return self->materialsInWorld;
}
@end
