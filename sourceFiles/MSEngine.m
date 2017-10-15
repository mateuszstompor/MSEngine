//
//  MSEngine.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 10/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSEngine.h"
#import "MSLoader.h"
#import "MSWorld.h"
#import "MSPuppet.h"
#import "MSPointLight.h"
#import "MSRenderOpenGL.h"
#import "MSCamera.h"

@implementation MSEngine
{
    MSLoader* loader;
    MSWorld* world;
    MSRender* renderer;
    
}
-(instancetype)init {
    self = [super init];
    if(self){
        
    }
    return self;
}
-(NSArray<id<MSPositionedLight>>*)getPointLights {
    return [self->world getLightSources];
}
+(MSEngine*)getInstance {
    static MSEngine* engine;
    if (engine == nil) {
        engine = [[super alloc] init];
        engine->loader = [[MSLoader alloc] initRecursiveSearcher:5];
        engine->world = [[MSWorld alloc] init];
    }
    return engine;
}
-(void)addSearchPath:(NSString *)path {
    [self->loader addSearchPath:path];
}
-(NSArray<id<MSPositionedObject>>*)loadModelToCurrentWorld: (NSString*) modelName transformationMatrix: (MSMatrix4D*) transformation {
    NSArray<MSModelFraction*>* model = [loader loadModel:modelName];
    if (model) {
        [self->world addModelToWorld:[[MSPuppet alloc] initWithModel:model]];
    }
    return model;
}
-(id<MSPositionedObject>)addCameraWithFov: (float) fov aspectRatio: (float) aspect nearPlane: (float) np farPlane: (float) far transformationMatrix: (MSMatrix4D*) transformation {
    MSCamera* camera = [[MSCamera alloc] initWithFOV:fov aspectRatio:aspect near:np far:far];
    [self->world setCamera: camera];
    self->renderer = [[MSRenderOpenGL alloc] initWithWorld:self->world];
    return camera;
}
-(id<MSPositionedLight>)loadOmniLightToCurrentWorld: (NSString*)modelName color:
(MSVector3D*) color power: (float) pw transformationMatrix: (MSMatrix4D*) transformation {
    NSArray<MSModelFraction*>* model = [loader loadModel:modelName];
    if (model) {
        MSPointLight* light = [[MSPointLight alloc] initWithModel:model color:color power:pw];
        [self->world addLightSourceToWorld: light];
        return light;
    }
    return nil;
}
-(void)loadMaterialsToCurrentWorld: (NSString*) materials {
    NSArray<MSMaterial*>* mat = [loader loadMaterials:materials];
    if (mat) {
        MSMaterialStore* store = [[MSMaterialStore alloc] init];
        [store addMaterials:mat];
        NSArray<MSTexture*>* textures = [loader loadTexturesForMaterials:mat];
        [store addTextures:textures];
        [self->world setMaterialStore:store];
    }
}
-(void)drawScene {
    if([world getCamera] != nil) {
        [self->renderer drawScene];
    }
}
-(float)getFrameRate {
    return [renderer getCurrentFrameRate];
}
@end
