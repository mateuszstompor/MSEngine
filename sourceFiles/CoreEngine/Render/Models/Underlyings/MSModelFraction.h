//
//  MSModelFraction.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#if macOS
#import <OpenGL/gl3.h>
#import <OpenGL/gl.h>
#import <Cocoa/Cocoa.h>
#endif

#if iOS
#import <Foundation/Foundation.h>
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>
#endif

#import "MSPoint.h"
#import "MSModelFace.h"
#import "MSVectorND.h"


#ifndef MSMODELFRACTION_H
#define MSMODELFRACTION_H
@interface MSModelFraction : NSObject
{
    NSMutableArray<MSPoint3D*>* vertices;
    NSMutableArray<MSPoint3D*>* normals;
    NSMutableArray<MSPoint2D*>* textureCoordinates;
    NSMutableArray<MSModelFace*>* facesData;
    MSVector3D* fractionColor;
    NSString* name;
    GLuint dataVBO;
    GLuint verticiesVAO;
    BOOL isLoadedToGraphics;
    
}
-(instancetype)init;
-(void)addVertex: (MSPoint3D*)point;
-(void)addNormal: (MSPoint3D*)point;
-(void)addTextureCoordinate: (MSPoint2D*)point;
-(void)addFace: (MSModelFace*)face;
-(void)setName: (NSString*)newName;
-(NSUInteger)amountOfVerts;
-(NSUInteger)amountOfNormals;
-(NSUInteger)amountOfTextureCoordinates;
-(void)printVerts;
-(long long)amountOfElemntsToLoadToGraphics;
-(GLuint)getVerticiesVAO;
-(GLuint)getBuffer;
-(void)loadDataToGraphicsCard;
-(NSString*)getName;
-(float*)getColor;
@end
#endif
