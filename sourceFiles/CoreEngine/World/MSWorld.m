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
-(void)translateObject: (MSModelTransform*)obj x:(float)x y:(float)y z:(float)z{
    [obj translateModelBy: [MSTransformationManager translationMatrix4x4:x y:y z:z]];
}
-(void)rotateObject: (MSModelTransform*)obj x:(float)x y:(float)y z:(float)z{
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
