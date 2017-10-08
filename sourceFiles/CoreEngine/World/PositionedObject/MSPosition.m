//
//  MSPosition.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 08/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPosition.h"

@implementation MSPosition
-(instancetype)initWithDimension: (int)dimension {
    self = [super init];
    if(self) {
        self->dimension = dimension;
        self->modelRotation = [MSMatrixND identityMatrix:dimension];
        self->modelTranslation = [MSMatrixND identityMatrix:dimension];
        self->modelScale = [MSMatrixND identityMatrix:dimension];
    }
    return self;
}
-(MSMatrixND*)translateModelBy: (MSMatrix4D*) tr {
    self->modelTranslation = [tr multiplyByMatrix:self->modelTranslation];
    return self->modelTranslation;
}
-(MSMatrixND*)rotateModelBy: (MSMatrix4D*) rot {
    self->modelRotation = [rot multiplyByMatrix:self->modelRotation];
    return self->modelRotation;
}
-(MSMatrixND*)scaleModelBy:(MSMatrix4D*) sc {
    self->modelScale = [sc multiplyByMatrix:self->modelScale];
    return self->modelScale;
}
-(MSMatrixND*)modelTranslation{
    return self->modelTranslation;
}
-(MSMatrixND*)modelRotation {
    return self->modelRotation;
}
-(MSMatrixND*)modelScale {
    return self->modelScale;
}
@end
