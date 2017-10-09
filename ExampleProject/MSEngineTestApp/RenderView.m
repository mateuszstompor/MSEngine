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
    MSLoader* loader;
    CMMotionManager* manager;
    NSOperationQueue* queue;
}

-(void)setUp {
    self->queue = [[NSOperationQueue alloc] init];
    self->manager = [[CMMotionManager alloc] init];
    if (manager.isDeviceMotionAvailable) {
        [manager setDeviceMotionUpdateInterval:0.01];
        [manager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            if (motion) {
                
            }
        }];
    }
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    loader = [[MSLoader alloc] initRecursiveSearcher:3];
    [loader addSearchPath:[[NSBundle mainBundle] bundlePath]];
    
    [EAGLContext setCurrentContext:[self context]];    
    
    MSVector3D* firstColor = [[MSVector3D alloc] initWithComponents:3, 1.0f, 1.0f, 1.0f];
    
    MSMaterialStore* materialStore = [[MSMaterialStore alloc] init];
    NSArray<MSMaterial*>* materials = [loader loadMaterials:@"classroom.mtl"];
    NSArray<MSTexture*>* textures = [loader loadTexturesForMaterials:materials];
    [materialStore addMaterials:materials];
    [materialStore addTextures: textures];
    
    NSArray<MSModelFraction*>* lightModel = [loader loadModel:@"simpleCube.obj"];


    MSPointLight* light = [[MSPointLight alloc] initWithModel: lightModel color:firstColor power:5000.0f];
    
    
    [[light getTransformation] scaleModelBy:[MSTransformationManager scaleMatrix4x4:0.2 repeatToIndex:2]];
    [[[[light getModelComponents] objectAtIndex:0] getTransformation] scaleModelBy:[MSTransformationManager scaleMatrix4x4:0.02 repeatToIndex:2]];
    

    
    MSPuppet* classroom = [[MSPuppet alloc] initWithModel:[loader loadModel:@"classroom.obj"]];
    MSCamera* cam = [[MSCamera alloc] initWithFOV:120 aspectRatio:width/height near:0.1 far:1000];

    world = [[MSWorld alloc] initWithMaterials:materialStore camera: cam];
    [world addLightSourceToWorld:light];

    [world addModelToWorld:classroom];
    renderer = [[MSRenderOpenGL alloc] initWithWorld:world];

}
- (void)drawRect:(CGRect)rect {
    float fraction = 0.006;
    float rotationFraction = 0.008;
    float yTranslation = zTranslation/5000.0f;
    [EAGLContext setCurrentContext:[self context]];
    if(renderer!=nil){
        MSMatrix4D* camRot = [[[world getCamera] getTransformation] modelRotation];
        MSVector4D* direction = [[MSVectorND alloc] initVecWithDimension:3];
        [direction setValueAtIdenx:0 value:[camRot getValueAtRowIndex:2 andColumnIndex:0]];
        [direction setValueAtIdenx:1 value:[camRot getValueAtRowIndex:2 andColumnIndex:1]];
        [direction setValueAtIdenx:2 value:[camRot getValueAtRowIndex:2 andColumnIndex:2]];
        MSVector4D* right = [[MSVectorND alloc] initVecWithDimension:3];
        [right setValueAtIdenx:0 value:[camRot getValueAtRowIndex:0 andColumnIndex:0]];
        [right setValueAtIdenx:1 value:[camRot getValueAtRowIndex:0 andColumnIndex:1]];
        [right setValueAtIdenx:2 value:[camRot getValueAtRowIndex:0 andColumnIndex:2]];
        
        [world translateObject:[[world getCamera] getTransformation] x:self->translation.y*[direction valueAtIndex:0]*fraction y:self->translation.y*[direction valueAtIndex:1]*fraction z:self->translation.y*[direction valueAtIndex:2]*fraction];
        [world translateObject:[[world getCamera] getTransformation] x:-self->translation.x*[right valueAtIndex:0]*fraction y:-self->translation.x*[right valueAtIndex:1]*fraction z:-self->translation.x*[right valueAtIndex:2]*fraction];
        [world rotateObject:[[world getCamera] getTransformation] x:-self->rotation.y*rotationFraction y:-self->rotation.x*rotationFraction z:0.0];
        [self->labelToUpdate setText:[[NSString alloc] initWithFormat:@"%.1f",[self->renderer getCurrentFrameRate]]];
        [renderer drawScene];
        GLenum err;
        
        if((err = glGetError()) != GL_NO_ERROR){
            NSLog(@"jest błąd %i", err);
        }
    }
}

@end
