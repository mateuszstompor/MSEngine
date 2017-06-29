//
//  MSCamera.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 30/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSCamera.h"

@implementation MSCamera

@synthesize scale;
@synthesize translation;
@synthesize rotation;

-(instancetype)initWithFOV: (float)fieldOV aspectRatio: (float)ar near: (float) nearPlane far: (float) farPlane{
    self=[super init];
    if(self){
        self->scale=[MSMatrixND identityMatrix:4];
        self->translation=[MSMatrixND identityMatrix:4];
        self->rotation=[MSMatrixND identityMatrix:4];
        self->projectionMatrix=[MSTransformationManager perpsectiveWithFoV:fieldOV aspectRatio:ar near:nearPlane far:farPlane];
    }
    return self;
}
-(MSMatrixND*)getProjectionMatrix{
    return self->projectionMatrix;
}
-(void)translateBy: (MSMatrixND*) tr{
    self->translation=[tr multiplyByMatrix:translation];
}
-(void)rotateBy: (MSMatrixND*) rot{
    self->rotation=[rot multiplyByMatrix:rotation];
}
-(void)scaleBy:(MSMatrixND*) sc{
    self->scale=[sc multiplyByMatrix:self->scale];
}

@end
