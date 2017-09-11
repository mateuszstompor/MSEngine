//
//  MSModelFraction.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPoint.h"
#import "MSModelFace.h"
#import "MSVectorND.h"
#import "MSMaterial.h"
#import "MSPositionedObject.h"

#ifndef MSMODELFRACTION_H
#define MSMODELFRACTION_H
@interface MSModelFraction : NSObject <MSPositionedObject>

@property (atomic) NSMutableArray<MSPoint3D*>* vertices;
@property (atomic) NSMutableArray<MSPoint3D*>* normals;
@property (atomic) NSMutableArray<MSPoint2D*>* textureCoordinates;
@property (atomic) NSMutableArray<MSModelFace*>* facesData;
@property (atomic) NSString* materialName;
@property (atomic) NSString* name;
@property (atomic) NSValue* uniqueName;

-(instancetype)init;
-(NSValue*)getUniqueName;

@end
#endif
