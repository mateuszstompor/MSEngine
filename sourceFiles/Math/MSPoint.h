//
//  MSPoint.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdio.h>


#ifndef MSPOINT_H
#define MSPOINT_H

@interface MSPoint : NSObject
{
    int dimension;
    float* components;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithDimension: (int)dim;
-(instancetype)initWithComponents: (int)dim,...;
-(instancetype)init2DimPointWithX: (float)x y: (float)y;
-(instancetype)init3DimPointWithX: (float)x y: (float)y z:(float)z;
-(float)getComponent: (int)index;
-(int)getDimension;
-(void)setComponent: (int)index value:(float)val;
-(void)printPoint;
-(void)dealloc;
-(float*)getComponents;
@end
typedef  MSPoint MSPoint2D;
typedef  MSPoint MSPoint3D;
#endif
