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
        self->camera=[[MSCamera alloc]init];
        self->objectsInWorld=[[NSMutableArray alloc]init];
        self->lightSources=[[NSMutableArray alloc]init];
    }
    return self;
}
-(void)translateCameraX: (float)x y:(float)y z:(float)z{
    [camera lockObject];
    [camera multiplyTranslationBy:[MSTransformationManager translationMatrix4x4:x y:y z:z]];
    [camera unLockObject];
}
-(void)translatelight: (MSLightSource*)light x: (float)x y:(float)y z:(float)z{
    [light lockObject];
    [light multiplyTranslationBy:[MSTransformationManager translationMatrix4x4:x y:y z:z]];
    [light unLockObject];
}
-(void)rotateCameraX: (float)x y:(float)y z:(float)z{
    [camera lockObject];
    [camera multiplyRotationnBy:[MSTransformationManager rotationMatrixAboutXinRadians4x4:x]];
    [camera multiplyRotationnBy:[MSTransformationManager rotationMatrixAboutYinRadians4x4:y]];
    [camera multiplyRotationnBy:[MSTransformationManager rotationMatrixAboutZinRadians4x4:z]];
    [camera unLockObject];
}
-(MSCamera*)getCamera{
    return self->camera;
}
-(NSMutableArray<MSLightSource*>*)getLightSources{
    return lightSources;
}
-(void)addLightSourceToWorld: (MSLightSource*)lght{
    [lightSources addObject:lght];
}
-(NSMutableArray<MSPuppet*>*)getModels{
    return objectsInWorld;
}
-(void)addModelToWorld: (MSPuppet*)pup{
    [objectsInWorld addObject:pup];
}
@end
