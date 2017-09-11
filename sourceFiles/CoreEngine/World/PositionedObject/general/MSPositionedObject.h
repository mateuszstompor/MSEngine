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


@property (readonly) MSMatrix4D* modelScale;
@property (readonly) MSMatrix4D* modelRotation;
@property (readonly) MSMatrix4D* modelTranslation;

-(void)translateModelBy: (MSMatrix4D*) tr;
-(void)rotateModelBy: (MSMatrix4D*) rot;
-(void)scaleModelBy:(MSMatrix4D*) sc;

@end
#endif
