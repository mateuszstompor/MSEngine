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
    id<MSPositionedObject> camera;
}

-(void)setUp {

    float width = self.bounds.size.width;
    float height = self.bounds.size.height;

    
    [EAGLContext setCurrentContext:[self context]];    
    engine = [[MSEngine alloc] init];
    [engine addSearchPath:[[NSBundle mainBundle] bundlePath]];
    
    [engine loadMaterialsToCurrentWorld:@"classroom.mtl"];
    MSVector3D* firstColor = [[MSVector3D alloc] initWithComponents:3, 1.0f, 1.0f, 1.0f];
    NSArray<id<MSPositionedObject>>* ar = [engine loadOmniLightToCurrentWorld:@"simpleCube.obj" color:firstColor power: 200 transformationMatrix:[MSMatrixND identityMatrix:4]];
    id<MSPositionedObject> lightModel = [ar objectAtIndex: 0];
    [[lightModel getTransformation] scaleBy:[[MSVectorND alloc] initWithComponents:4, 0.2, 0.2, 0.2, 1.0]];
    [engine loadModelToCurrentWorld:@"classroom.obj" transformationMatrix:[MSMatrixND identityMatrix:4]];
    self->camera = [engine addCameraWithFov:120 aspectRatio:width/height nearPlane:0.1 farPlane:1000 transformationMatrix:[MSMatrixND identityMatrix:4]];
}
- (void)drawRect:(CGRect)rect {
    float fraction = 0.006;
    float rotationFraction = 0.008;
    float yTranslation = zTranslation/5000.0f;
    [EAGLContext setCurrentContext:[self context]];
    if(engine!=nil){
        
        MSVector4D* direction = [[camera getTransformation] direction];
        MSVector4D* right = [[camera getTransformation] right];
        [direction multiplyByScalar:self->translation.y*fraction];
        [right multiplyByScalar:-self->translation.x*fraction];
        [[camera getTransformation] translateBy: direction];
        [[camera getTransformation] translateBy: right];
        [[camera getTransformation] rotateByAngleInRadians:-self->rotation.y*rotationFraction y:-self->rotation.x*rotationFraction z:0.0];
        [self->labelToUpdate setText:[[NSString alloc] initWithFormat:@"%.1f",[engine getFrameRate]]];
        [engine drawScene];
    }
}

@end
