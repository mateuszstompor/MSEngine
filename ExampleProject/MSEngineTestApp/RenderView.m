//
//  RenderView.m
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 02/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "RenderView.h"

@implementation RenderView
-(void)setUp {
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    [EAGLContext setCurrentContext:[self context]];
    
    NSString* pathToClassroomMaterials = [[NSBundle mainBundle] pathForResource:@"classroom" ofType:@"mtl"];
    NSString* pathToClassroomModel = [[NSBundle mainBundle] pathForResource:@"classroom" ofType:@"obj"];
    NSString* bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/"];
    NSString* pathToCube = [[NSBundle mainBundle] pathForResource:@"simpleCube" ofType:@"obj"];
    
    MSVector3D* firstColor = [[MSVector3D alloc] initWithComponents:3, 1.0f, 1.0f, 1.0f];
    MSVector3D* secondColor = [[MSVector3D alloc] initWithComponents:3, 0.7f, 0.9f, 1.0f];
    
    
    GLuint modelShader = [MSEngineUtility shaderProgramFromFiles: bundlePath vertexShader:@"VShader.vert" fragmentShader:@"FShader.frag"];
    GLuint lightShader = [MSEngineUtility shaderProgramFromFiles: bundlePath vertexShader:@"VShader.vert" fragmentShader:@"LightShader.frag"];
    
    MSMaterialStore* materialStore = [MSLoaderMTL loadMaterials:[pathToClassroomMaterials UTF8String]];

    
    NSArray<MSModelFraction*>* lightModel = [MSLoaderOBJ loadModel:[pathToCube UTF8String] tieWithMaterials:materialStore];
    MSLightSource* light = [[MSLightSource alloc] initWithModel: lightModel color:firstColor power:50.0f];
    
    

    [light scaleBy:[MSTransformationManager scaleMatrix4x4:0.05 repeatToIndex:2]];
    MSLightSource* secondLight = [[MSLightSource alloc] initWithModel: lightModel color:secondColor power:80.0f];

    [secondLight scaleBy:[MSTransformationManager scaleMatrix4x4:0.05 repeatToIndex:2]];

    
    MSPuppet* classroom = [[MSPuppet alloc] initWithModel:[MSLoaderOBJ loadModel:[pathToClassroomModel UTF8String] tieWithMaterials:materialStore]];
    MSCamera* cam = [[MSCamera alloc] initWithFOV:120 aspectRatio:width/height near:0.1 far:1000];

    world = [[MSWorld alloc] initWithMaterials:materialStore camera: cam];
    [world addLightSourceToWorld:light];
    [world addLightSourceToWorld:secondLight];
    [world addModelToWorld:classroom];
    renderer = [[MSRenderOpenGL alloc] initWithWorld:world modelShader:modelShader lightShader:lightShader];

}

- (void)drawRect:(CGRect)rect {
    float fraction = 0.05;
    float rotationFraction = 0.1;
    [EAGLContext setCurrentContext:[self context]];
    if(renderer!=nil){
        [world translateObject:[world getCamera] x:-self->translation.x*fraction y:0 z:self->translation.y*fraction];

        [world rotateObject:[world getCamera] x:-self->rotation.y*rotationFraction y:-self->rotation.x*rotationFraction z:0.0];
        [self->labelToUpdate setText:[[NSString alloc] initWithFormat:@"%.1f",[self->renderer getCurrentFrameRate]]];
        [renderer drawScene];
    }
}

@end
