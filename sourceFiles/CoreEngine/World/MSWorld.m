//
//  MSPlane.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSWorld.h"

@implementation MSWorld
-(instancetype)initWithMaterials: (MSMaterialStore*)store{
    self=[super init];
    if(self){
        self->camera=[[MSPuppet alloc]initWithModel:nil];
        self->objectsInWorld=[[NSMutableArray alloc]init];
        self->lightSources=[[NSMutableArray alloc]init];
        self->materialsInWorld=store;
    }
    return self;
}
-(void)translateCameraX: (float)x y:(float)y z:(float)z{
    [camera translateBy:[MSTransformationManager translationMatrix4x4:x y:y z:z]];
}
-(void)translatelight: (MSLightSource*)light x: (float)x y:(float)y z:(float)z{
    [light translateBy:[MSTransformationManager translationMatrix4x4:x y:y z:z]];
}
-(void)rotateCameraX: (float)x y:(float)y z:(float)z{
    [camera rotateBy:[MSTransformationManager rotationMatrixAboutXinRadians4x4:x]];
    [camera rotateBy:[MSTransformationManager rotationMatrixAboutYinRadians4x4:y]];
    [camera rotateBy:[MSTransformationManager rotationMatrixAboutZinRadians4x4:z]];
}
-(id<MSPositionedObject>)getCamera{
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
-(MSMaterialStore*)getAvailavleMaterials{
    return self->materialsInWorld;
}
@end
