//
//  MSPositionedObject.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPositionedObject.h"

@implementation MSPositionedObject
-(instancetype)initWithScale: (MSMatrix4D*)scaleM rotation: (MSMatrix4D*)rotationM translation:(MSMatrix4D*)trM{
    self=[super init];
    if(self){
        self->scale=scaleM;
        self->rotation=rotationM;
        self->translation=trM;
        objectLock=[[NSLock alloc]init];
    }
    return self;
}
-(instancetype)init{
    self=[self initWithScale:[MSMatrixND identityMatrix:4] rotation:[MSMatrixND identityMatrix:4] translation:[MSMatrixND identityMatrix:4]];
    return self;
}
-(MSMatrix4D*)getTransformationMatrix{
    return [[rotation multiplyByMatrix:scale] multiplyByMatrix:translation];
}
-(MSMatrix4D*)getScale{
    return self->scale;
}
-(MSMatrix4D*)getRotation{
    return self->rotation;
}
-(MSMatrix4D*)getTranslation{
    return self->translation;
}
-(void)multiplyTranslationBy: (MSMatrixND*) tr{
    self->translation=[tr multiplyByMatrix:translation];
}
-(void)multiplyRotationnBy: (MSMatrixND*) rot{
    self->rotation=[rot multiplyByMatrix:rotation];
}
-(void)multiplyScaleBy:(MSMatrixND*) sc{
    self->scale=[sc multiplyByMatrix:self->scale];
}
-(void)lockObject{
    [objectLock lock];
}
-(void)unLockObject{
    [objectLock unlock];
}
@end
