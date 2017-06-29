////
////  MSRender.m
////  MSGraphicsEngine
////
////  Created by Mateusz Stompór on 23/04/2017.
////  Copyright © 2017 Mateusz Stompór. All rights reserved.
////
//
//#import "MSRender.h"
//
//
//
//@implementation MSRender
//-(void)drawObject: (MSPuppet*)model withProgram: (GLuint)shProg{
//    for(MSModelFraction* frac in [model getModelComponents]){
//        [self drawFraction:frac model:model program:shProg];
//        
//    }
//}
//-(void)drawFraction:(MSModelFraction*)frac model:(MSPuppet*)md program: (GLuint)shProg{

//    [self loadTransformationFromModelToShader: md shaderProgram:shProg];
//    [self updateCameraPositionInShader: shProg];
//


//}
//-(void)drawEverything{
//    [self clear];
//    for (MSPuppet* mod in [world getModels]){
//        [self drawObject:mod withProgram:shaderProgram];
//    }
//    for(MSLightSource* light in [world getLightSources]){
//        [self drawObject:light withProgram:lightShaderProgram];
//    }
//}





//@end
