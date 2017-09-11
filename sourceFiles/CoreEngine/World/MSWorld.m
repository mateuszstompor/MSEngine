//
//  MSPlane.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSWorld.h"

@implementation MSWorld
-(instancetype)initWithMaterials: (MSMaterialStore*)store camera: (MSCamera*)cam{
    self=[super init];
    if(self){
        self->camera=cam;
        self->objectsInWorld=[[NSMutableArray alloc]init];
        self->lightSources=[[NSMutableArray alloc]init];
        self->materialsInWorld=store;
    }
    return self;
}
-(void)translateObject: (id<MSPositionedObject>)obj x:(float)x y:(float)y z:(float)z{
    [obj translateModelBy: [MSTransformationManager translationMatrix4x4:x y:y z:z]];
}
-(void)rotateObject: (id<MSPositionedObject>)obj x:(float)x y:(float)y z:(float)z{
    [obj rotateModelBy:[MSTransformationManager rotationMatrixAboutXinRadians4x4:x]];
    [obj rotateModelBy:[MSTransformationManager rotationMatrixAboutYinRadians4x4:y]];
    [obj rotateModelBy:[MSTransformationManager rotationMatrixAboutZinRadians4x4:z]];
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
