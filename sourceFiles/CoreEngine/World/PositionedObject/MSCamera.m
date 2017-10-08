//
//  MSCamera.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 30/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSCamera.h"

@implementation MSCamera
{
    MSModelTransform* transformation;
}

-(instancetype)initWithFOV: (float)fieldOV aspectRatio: (float)ar near: (float) nearPlane far: (float) farPlane{
    self=[super init];
    if(self){
        self->transformation = [[MSModelTransform alloc] initWithDimension:4];
        self->projectionMatrix=[MSTransformationManager perpsectiveWithFoV:fieldOV aspectRatio:ar near:nearPlane far:farPlane];
    }
    return self;
}
-(MSMatrixND*)getProjectionMatrix{
    return self->projectionMatrix;
}
-(MSModelTransform*) getTransformation {
    return self->transformation;
}

@end
