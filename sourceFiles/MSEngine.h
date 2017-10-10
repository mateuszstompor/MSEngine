//
//  MSEngine.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 10/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSPositionedObject.h"
#import "MSMatrixND.h"
#import "MSVectorND.h"

#ifndef MSEngine_h
#define MSEngine_h
@interface MSEngine : NSObject
-(instancetype)init;
-(void)addSearchPath: (NSString*) path;
-(NSArray<id<MSPositionedObject>>*)loadModelToCurrentWorld: (NSString*) modelName transformationMatrix: (MSMatrix4D*) transformation;
-(NSArray<id<MSPositionedObject>>*)loadOmniLightToCurrentWorld: (NSString*)modelName color:
(MSVector3D*) color power: (float) pw transformationMatrix: (MSMatrix4D*) transformation;
-(void)loadMaterialsToCurrentWorld: (NSString*) materials;
-(id<MSPositionedObject>)addCameraWithFov: (float) fov aspectRatio: (float) aspect nearPlane: (float) np farPlane: (float) far transformationMatrix: (MSMatrix4D*) transformation;
-(void)drawScene;
-(float)getFrameRate;
@end
#endif
