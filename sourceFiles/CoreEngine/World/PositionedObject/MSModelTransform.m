//
//  MSModelTransform.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 08/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSModelTransform.h"
#import "MSTransformationManager.h"

@implementation MSModelTransform
-(instancetype)initWithDimension: (int) dim {
    self = [super init];
    if(self) {
        self->dimension = dim;
        self->modelRotation = [MSMatrixND identityMatrix:dim];
        self->modelScale = [MSMatrixND identityMatrix:dim];
        self->modelTranslation = [MSMatrixND identityMatrix:dim];
    }
    return self;
}
-(MSMatrixND*)translateModelBy: (MSMatrixND*) tr {
    self->modelTranslation = [tr multiplyByMatrix:self->modelTranslation];
    return self->modelTranslation;
}
-(MSMatrixND*)rotateModelBy: (MSMatrixND*) rot {
    self->modelRotation = [rot multiplyByMatrix:self->modelRotation];
    return self->modelRotation;
}
-(MSMatrixND*)scaleModelBy:(MSMatrixND*) sc {
    self->modelScale = [sc multiplyByMatrix:self->modelScale];
    return self->modelScale;
}
-(MSMatrixND*)modelScale {
    return self->modelScale;
}
-(MSMatrixND*)modelRotation {
    return self->modelRotation;
}
-(MSMatrixND*)modelTranslation {
    return self->modelTranslation;
}
-(void)translateBy: (MSVectorND*) vector{
    MSMatrixND* translationMatrix = [MSTransformationManager translationMatrix4x4:[vector valueAtIndex:0]
                                                                                y:[vector valueAtIndex:1]
                                                                                z:[vector valueAtIndex:2]];
    self->modelTranslation = [translationMatrix multiplyByMatrix:self->modelTranslation];
}
-(void)rotateByAngleInRadians: (float) x y: (float) y z: (float) z {
    MSMatrixND* xMat = [MSTransformationManager rotationMatrixAboutXinRadians4x4:x];
    MSMatrixND* yMat = [MSTransformationManager rotationMatrixAboutYinRadians4x4:y];
    MSMatrixND* zMat = [MSTransformationManager rotationMatrixAboutZinRadians4x4:z];
    [self rotateModelBy:[zMat multiplyByMatrix: [yMat multiplyByMatrix: xMat]]];
}
-(MSVectorND*)right {
    MSVectorND* right = [[MSVectorND alloc] initVecWithDimension:self->dimension];
    for (int index = 0; index<self->dimension-1; ++index) {
        [right setValueAtIdenx:index value:[modelRotation getValueAtRowIndex:0 andColumnIndex:index]];
    }
    [right setValueAtIdenx:self->dimension-1 value:1.0f];
    return right;
}
-(MSVectorND*)direction {
    MSVectorND* directionVector = [[MSVectorND alloc] initVecWithDimension:self->dimension];
    for (int index = 0; index<self->dimension-1; ++index) {
        [directionVector setValueAtIdenx:index value:[modelRotation getValueAtRowIndex:dimension-2 andColumnIndex:index]];
    }
    [directionVector setValueAtIdenx:self->dimension-1 value:1.0f];
    return directionVector;
}
-(void)scaleBy:(MSVectorND*) sc {
    MSMatrixND* scaleMatrix = [MSMatrixND identityMatrix:self->dimension];
    for (int i=0; i<dimension-1; ++i) {
        [scaleMatrix setValueAtRowIndex:i andColumnIndex:i value:[sc valueAtIndex:i]];
    }
    self->modelScale = [scaleMatrix multiplyByMatrix:self->modelScale];
}
@end
