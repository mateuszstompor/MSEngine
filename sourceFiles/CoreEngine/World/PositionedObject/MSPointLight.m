//
//  MSLightSource.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 03/05/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPointLight.h"

@implementation MSPointLight

@synthesize color;
@synthesize power;
@synthesize modelScale;
@synthesize modelRotation;
@synthesize modelTranslation;

-(instancetype _Nullable)initWithModel: (NSArray<MSModelFraction*>* _Nonnull)mod
                                          color: (MSVector3D*) col power: (float)pw{
    self=[super initWithModel: mod];
    if(self){
        self->color=col;
        self->power=pw;
        self->modelRotation = [MSMatrixND identityMatrix:4];
        self->modelScale = [MSMatrixND identityMatrix:4];
        self->modelTranslation = [MSMatrixND identityMatrix:4];
    }
    return self;
}
-(void)translateModelBy: (MSMatrixND*) tr{
    self->modelTranslation=[tr multiplyByMatrix:modelTranslation];
    for (MSModelFraction* fraction in self->model) {
        [fraction translateModelBy:tr];
    }
}
-(void)rotateModelBy: (MSMatrixND*) rot{
    self->modelRotation=[rot multiplyByMatrix:modelRotation];
    for (MSModelFraction* fraction in self->model) {
        [fraction rotateModelBy:rot];
    }
}
-(void)scaleModelBy:(MSMatrixND*) sc{
    self->modelScale=[sc multiplyByMatrix:self->modelScale];
    for (MSModelFraction* fraction in self->model) {
        [fraction scaleModelBy:sc];
    }
}

@end
