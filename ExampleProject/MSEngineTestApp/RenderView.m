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
    MSPointLight* light = [[MSPointLight alloc] initWithModel: lightModel color:firstColor power:50.0f];
    
    

    [light scaleBy:[MSTransformationManager scaleMatrix4x4:0.05 repeatToIndex:2]];
    MSPointLight* secondLight = [[MSPointLight alloc] initWithModel: lightModel color:secondColor power:80.0f];

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
    NSLog(@"%f", [self cpu_usage]);
}


-(float) cpu_usage{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads
    
    basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    if (thread_count > 0)
        stat_thread += thread_count;
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < (int)thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->user_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
        
    } // for each thread
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    
    return tot_cpu;
}

@end
