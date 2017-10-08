//
//  MSModelTransform.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 08/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSModelTransform.h"

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
@end
