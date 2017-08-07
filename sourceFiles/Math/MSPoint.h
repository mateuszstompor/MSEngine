//
//  MSPoint.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef MSPOINT_H
#define MSPOINT_H

@interface MSPoint : NSObject
{
    unsigned int dimension;
    float* components;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithDimension: (unsigned int const)dim;
-(instancetype)initZeroPointWithDimension: (unsigned int const)dim;

-(instancetype)initWithComponents: (unsigned int const)dim,...;
-(instancetype)init2DimPointWithX: (float const)x y: (float const)y;
-(instancetype)init3DimPointWithX: (float const)x y: (float const)y z:(float const)z;


-(float const)getComponent: (unsigned int const)index;
-(float const)safeGetComponent: (unsigned int const)index;

-(unsigned int const)getDimension;

-(void)setComponent: (unsigned int const)index value:(float const)val;
-(void)safeSetComponent: (unsigned int const)index value:(float const)val;

-(void)checkIndexBound:(unsigned int const)index;

-(float const *)getComponents;

@end

typedef  MSPoint MSPoint2D;
typedef  MSPoint MSPoint3D;
typedef  MSPoint MSPoint4D;
#endif
