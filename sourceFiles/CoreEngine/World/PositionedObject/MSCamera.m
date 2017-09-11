//
//  MSCamera.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 30/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSCamera.h"

@implementation MSCamera

@synthesize modelScale;
@synthesize modelTranslation;
@synthesize modelRotation;

-(instancetype)initWithFOV: (float)fieldOV aspectRatio: (float)ar near: (float) nearPlane far: (float) farPlane{
    self=[super init];
    if(self){
        self->modelScale=[MSMatrixND identityMatrix:4];
        self->modelTranslation=[MSMatrixND identityMatrix:4];
        self->modelRotation=[MSMatrixND identityMatrix:4];
        self->projectionMatrix=[MSTransformationManager perpsectiveWithFoV:fieldOV aspectRatio:ar near:nearPlane far:farPlane];
    }
    return self;
}
-(MSMatrixND*)getProjectionMatrix{
    return self->projectionMatrix;
}
-(void)translateModelBy: (MSMatrixND*) tr{
    self->modelTranslation=[tr multiplyByMatrix:modelTranslation];
}
-(void)rotateModelBy: (MSMatrixND*) rot{
    self->modelRotation=[rot multiplyByMatrix:modelRotation];
}
-(void)scaleModelBy:(MSMatrixND*) sc{
    self->modelScale=[sc multiplyByMatrix:self->modelScale];
}

@end
