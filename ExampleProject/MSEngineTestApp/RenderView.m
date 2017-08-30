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

@implementation RenderView
{
    MSLoader* loader;
}

-(void)setUp {
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    loader = [[MSLoader alloc] initRecursiveSearcher:3];
    [loader addSearchPath:[[NSBundle mainBundle] bundlePath]];
    
    [EAGLContext setCurrentContext:[self context]];
    NSString* bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/"];
    
    
    MSVector3D* firstColor = [[MSVector3D alloc] initWithComponents:3, 1.0f, 1.0f, 1.0f];
    MSVector3D* secondColor = [[MSVector3D alloc] initWithComponents:3, 0.7f, 0.9f, 1.0f];
    
    
    GLuint modelShader = [MSEngineUtility shaderProgramFromFiles: bundlePath vertexShader:@"VShader.vert" fragmentShader:@"FShader.frag"];
    GLuint lightShader = [MSEngineUtility shaderProgramFromFiles: bundlePath vertexShader:@"VShader.vert" fragmentShader:@"LightShader.frag"];

    
    
    MSMaterialStore* materialStore = [[MSMaterialStore alloc] init];
    [materialStore addMaterials:[loader loadMaterials:@"classroom.mtl"]];

    
    NSArray<MSModelFraction*>* lightModel = [loader loadModel:@"simpleCube.obj"];
    MSPointLight* light = [[MSPointLight alloc] initWithModel: lightModel color:firstColor power:50.0f];
    
    

    [light scaleBy:[MSTransformationManager scaleMatrix4x4:0.05 repeatToIndex:2]];
    MSPointLight* secondLight = [[MSPointLight alloc] initWithModel: lightModel color:secondColor power:80.0f];

    [secondLight scaleBy:[MSTransformationManager scaleMatrix4x4:0.05 repeatToIndex:2]];

    
    MSPuppet* classroom = [[MSPuppet alloc] initWithModel:[loader loadModel:@"classroom.obj"]];
    MSCamera* cam = [[MSCamera alloc] initWithFOV:120 aspectRatio:width/height near:0.1 far:1000];

    world = [[MSWorld alloc] initWithMaterials:materialStore camera: cam];
    [world addLightSourceToWorld:light];
    [world addLightSourceToWorld:secondLight];
    [world addModelToWorld:classroom];
    renderer = [[MSRenderOpenGL alloc] initWithWorld:world modelShader:modelShader lightShader:lightShader];

}
- (void)drawRect:(CGRect)rect {
    float fraction = 0.006;
    float rotationFraction = 0.008;
    [EAGLContext setCurrentContext:[self context]];
    if(renderer!=nil){
        [world translateObject:[world getCamera] x:-self->translation.x*fraction y:0 z:self->translation.y*fraction];

        [world rotateObject:[world getCamera] x:-self->rotation.y*rotationFraction y:-self->rotation.x*rotationFraction z:0.0];
        [self->labelToUpdate setText:[[NSString alloc] initWithFormat:@"%.1f",[self->renderer getCurrentFrameRate]]];
        [renderer drawScene];
    }
}

@end
