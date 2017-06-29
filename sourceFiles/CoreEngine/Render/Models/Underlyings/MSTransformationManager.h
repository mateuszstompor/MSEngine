//
//  MSTransformationManager.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSMatrixND.h"
#import <math.h>


#ifndef MSTRANSFORMATIONMANAGER_H
#define MSTRANSFORMATIONMANAGER_H
@interface MSTransformationManager : NSObject
+(instancetype)alloc NS_UNAVAILABLE;
+(MSMatrixND*)rotationMatrixAboutXinRadians4x4: (float) radians;
+(MSMatrixND*)rotationMatrixAboutYinRadians4x4: (float) radians;
+(MSMatrixND*)rotationMatrixAboutZinRadians4x4: (float) radians;
+(MSMatrixND*)scaleMatrix4x4: (float)factor repeatToIndex: (int) repeat;
+(MSMatrixND*)translationMatrix4x4: (float)x y:(float)y z:(float)z;
+(MSMatrixND*)perpsectiveWithFoV: (float)fov aspectRatio: (float)ar near:(float)near far:(float)far;
@end
#endif
