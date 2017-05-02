//
//  ObjectInCoordinateSystem.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MSMatrixND.h"

#ifndef MSPOSITIONEDOBJECT_H
#define MSPOSITIONEDOBJECT_H
@interface MSPositionedObject : NSObject
{
    MSMatrix4D* scale;
    MSMatrix4D* rotation;
    MSMatrix4D* translation;
    NSLock* objectLock;
}
-(instancetype)init;
-(instancetype)initWithScale: (MSMatrix4D*)scaleM rotation: (MSMatrix4D*)rotationM translation:(MSMatrix4D*)trM;
-(MSMatrix4D*)getScale;
-(MSMatrix4D*)getRotation;
-(MSMatrix4D*)getTranslation;
-(MSMatrix4D*)getTransformationMatrix;
-(void)lockObject;
-(void)unLockObject;
-(void)multiplyTranslationBy: (MSMatrixND*) tr;
-(void)multiplyRotationnBy: (MSMatrixND*) rot;
@end
#endif
