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
    }
    return self;
}
-(void)translateCameraX: (float)x y:(float)y z:(float)z{
    [camera lockObject];
    [camera multiplyTranslationBy:[MSTransformationManager translationMatrix4x4:x y:y z:z]];
    [camera unLockObject];
}
-(MSCamera*)getCamera{
    return self->camera;
}
-(NSMutableArray<MSPuppet*>*)getModels{
    return objectsInWorld;
}
-(void)addModelToWorld: (MSPuppet*)pup{
    [objectsInWorld addObject:pup];
}
@end
