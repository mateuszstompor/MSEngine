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
@protocol MSPositionedObject


@property MSMatrix4D* scale;
@property MSMatrix4D* rotation;
@property MSMatrix4D* translation;

-(void)translateBy: (MSMatrixND*) tr;
-(void)rotateBy: (MSMatrixND*) rot;
-(void)scaleBy:(MSMatrixND*) sc;

@end
#endif
