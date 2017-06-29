//
//  MSCamera.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 30/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSPositionedObject.h"
#import "MSMatrixND.h"
#import "MSTransformationManager.h"

#ifndef MSCAMERA_H
#define MSCAMERA_H

@interface MSCamera : NSObject <MSPositionedObject>
{
    float aspectRatio;
    float fov;
    float near;
    float far;
    MSMatrixND* projectionMatrix;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithFOV: (float)fieldOV aspectRatio: (float)ar near: (float) nearPlane far: (float) farPlane;
-(MSMatrixND*)getProjectionMatrix;
@end

#endif
