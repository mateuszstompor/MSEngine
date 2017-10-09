//
//  RenderView.m
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 02/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "RenderView.h"
#import <mach/mach.h>
#import <assert.h>
#import <CoreMotion/CoreMotion.h>

@implementation RenderView
{
    MSEngine* engine;
}

-(void)setUp {

    float width = self.bounds.size.width;
    float height = self.bounds.size.height;

    
    [EAGLContext setCurrentContext:[self context]];    
    engine = [[MSEngine alloc] init];
    [engine addSearchPath:[[NSBundle mainBundle] bundlePath]];
    
    [engine loadMaterialsToCurrentWorld:@"classroom.mtl"];
    MSVector3D* firstColor = [[MSVector3D alloc] initWithComponents:3, 1.0f, 1.0f, 1.0f];
    [engine loadOmniLightToCurrentWorld:@"simpleCube.obj" color:firstColor power: 200 transformationMatrix:[MSMatrixND identityMatrix:4]];


    
    
//    [[light getTransformation] scaleModelBy:[MSTransformationManager scaleMatrix4x4:0.2 repeatToIndex:2]];
//    [[[[light getModelComponents] objectAtIndex:0] getTransformation] scaleModelBy:[MSTransformationManager scaleMatrix4x4:0.02 repeatToIndex:2]];
//

    [engine loadModelToCurrentWorld:@"classroom.obj" transformationMatrix:[MSMatrixND identityMatrix:4]];
    [engine addCameraWithFov:120 aspectRatio:width/height nearPlane:0.1 farPlane:1000 transformationMatrix:[MSMatrixND identityMatrix:4]];
}
- (void)drawRect:(CGRect)rect {
    float fraction = 0.006;
    float rotationFraction = 0.008;
    float yTranslation = zTranslation/5000.0f;
    [EAGLContext setCurrentContext:[self context]];
    if(engine!=nil){
//        MSMatrix4D* camRot = [[[world getCamera] getTransformation] modelRotation];
//        MSVector4D* direction = [[MSVectorND alloc] initVecWithDimension:3];
//        [direction setValueAtIdenx:0 value:[camRot getValueAtRowIndex:2 andColumnIndex:0]];
//        [direction setValueAtIdenx:1 value:[camRot getValueAtRowIndex:2 andColumnIndex:1]];
//        [direction setValueAtIdenx:2 value:[camRot getValueAtRowIndex:2 andColumnIndex:2]];
//        MSVector4D* right = [[MSVectorND alloc] initVecWithDimension:3];
//        [right setValueAtIdenx:0 value:[camRot getValueAtRowIndex:0 andColumnIndex:0]];
//        [right setValueAtIdenx:1 value:[camRot getValueAtRowIndex:0 andColumnIndex:1]];
//        [right setValueAtIdenx:2 value:[camRot getValueAtRowIndex:0 andColumnIndex:2]];
//
//        [world translateObject:[[world getCamera] getTransformation] x:self->translation.y*[direction valueAtIndex:0]*fraction y:self->translation.y*[direction valueAtIndex:1]*fraction z:self->translation.y*[direction valueAtIndex:2]*fraction];
//        [world translateObject:[[world getCamera] getTransformation] x:-self->translation.x*[right valueAtIndex:0]*fraction y:-self->translation.x*[right valueAtIndex:1]*fraction z:-self->translation.x*[right valueAtIndex:2]*fraction];
//        [world rotateObject:[[world getCamera] getTransformation] x:-self->rotation.y*rotationFraction y:-self->rotation.x*rotationFraction z:0.0];
//        [self->labelToUpdate setText:[[NSString alloc] initWithFormat:@"%.1f",[self->renderer getCurrentFrameRate]]];
        [engine drawScene];
    }
}

@end
