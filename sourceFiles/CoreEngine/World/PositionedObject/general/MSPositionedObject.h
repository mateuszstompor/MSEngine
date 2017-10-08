//
//  ObjectInCoordinateSystem.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MSModelTransform.h"

#ifndef MSPOSITIONEDOBJECT_H
#define MSPOSITIONEDOBJECT_H
@protocol MSPositionedObject

-(MSModelTransform*) getTransformation;

@end
#endif
