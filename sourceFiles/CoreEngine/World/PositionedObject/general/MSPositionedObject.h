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

-(MSMatrix4D*)getScale;
-(MSMatrix4D*)getRotation;
-(MSMatrix4D*)getTranslation;

-(void)translateBy: (MSMatrixND*) tr;
-(void)rotateBy: (MSMatrixND*) rot;
-(void)scaleBy:(MSMatrixND*) sc;

@end
#endif
