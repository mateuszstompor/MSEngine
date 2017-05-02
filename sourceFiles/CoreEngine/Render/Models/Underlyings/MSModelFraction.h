//
//  MSModelFraction.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGL/gl.h>
#import <OpenGL/gl3.h>

#import "MSPoint.h"
#import "MSModelFace.h"



#ifndef MSMODELFRACTION_H
#define MSMODELFRACTION_H
@interface MSModelFraction : NSObject
{
    NSMutableArray<MSPoint*>* vertices;
    NSMutableArray<MSPoint*>* normals;
    NSMutableArray<MSModelFace*>* facesData;
    NSString* name;
    GLuint dataVBO;
    GLuint verticiesVAO;
    GLuint orderEBO;
    BOOL isLoadedToGraphics;
    
}
-(instancetype)init;
-(void)addVertex: (MSPoint*)point;
-(void)addNormal: (MSPoint*)point;
-(void)addFace: (MSModelFace*)face;
-(void)setName: (NSString*)newName;
-(NSUInteger)amountOfVerts;
-(void)printVerts;
-(int)amountOfTriangleElements;
-(void)parseVertsToArray: (float*)tab;
-(void)parseOrderOfVertsToArray: (GLuint*)tab;
-(GLuint)getVerticiesVAO;
-(void)setAttrib: (GLuint)program;
-(GLuint)getBuffer;
-(void)loadDataToGraphicsCard;
-(GLuint)getElementsOrderBuffer;
-(NSString*)getName;
@end
#endif
