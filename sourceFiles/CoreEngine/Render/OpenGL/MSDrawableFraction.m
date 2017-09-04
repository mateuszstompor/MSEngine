//
//  MSDrawableModel.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 28/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSDrawableFraction.h"

#define DIMENSION_3D 3
#define DIMENSION_2D 2
#define POINTS_PER_FACE 3

@implementation MSDrawableFraction
@synthesize vao;
@synthesize verticesBuffer;
@synthesize textureBuffer;
@synthesize normalsBuffer;
-(instancetype)initWithFraction: (MSModelFraction*) pup{
    self=[super init];
    if(self){
        
        self->associatedFraction=pup;
        
        self->normalsBuffer=0;
        self->textureBuffer=0;
        self->verticesBuffer=0;
        self->indiciesToDraw=0;
        self->vao=0;
        self->isLoadedToGraphicsCard=NO;
        [self loadToGraphics];
    }
    return self;
}
-(BOOL)isloadedToGraphics{
    return self->isLoadedToGraphicsCard;
}

-(void)loadToGraphics{
    isLoadedToGraphicsCard=YES;
    glGenVertexArrays(1, &vao);
    glBindVertexArray(vao);
    verticesBuffer = [self genBufAndloadPointBasedData:[associatedFraction vertices]
                                    elementSizeInBytes:sizeof(float) selectorForField: @selector(getVertexIndex)];
    normalsBuffer = [self genBufAndloadPointBasedData:[associatedFraction normals]
                                    elementSizeInBytes:sizeof(float) selectorForField: @selector(getNormalIndex)];
    textureBuffer = [self genBufAndloadPointBasedData:[associatedFraction textureCoordinates]
                                   elementSizeInBytes:sizeof(float) selectorForField: @selector(getTextureCoordinateIndex)];
    glBindVertexArray(0);
}
-(GLuint)genBufAndloadPointBasedData: (NSArray<MSPoint*>*) data elementSizeInBytes: (size_t) siz selectorForField: (SEL) feedingFunction{
    GLuint bufferDescriptor=0;
    if([data  count] > 0){
        glGenBuffers(1, &bufferDescriptor);
        glBindBuffer(GL_ARRAY_BUFFER, bufferDescriptor);
        
        int dim = [[data objectAtIndex:0] getDimension];
        unsigned int writeIndex=0;
        unsigned int amountOfElements = dim*POINTS_PER_FACE*(unsigned int)[[associatedFraction facesData] count];
        glBufferData(GL_ARRAY_BUFFER, amountOfElements*siz, NULL, GL_STATIC_DRAW);
        indiciesToDraw=POINTS_PER_FACE*(unsigned int)[[associatedFraction facesData] count];
        float* buffer = glMapBufferRange(GL_ARRAY_BUFFER, 0, siz*amountOfElements, GL_MAP_WRITE_BIT);
        for(MSModelFace* face in [associatedFraction facesData]){
            for(MSVertexData* dat in [face getFaceData]){
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                unsigned int readIndex = (unsigned int)[dat performSelector:feedingFunction withObject:nil];
            #pragma clang diagnostic pop
            memcpy(buffer+writeIndex, [[data objectAtIndex: readIndex] getComponents], dim*siz);
            writeIndex+=dim;
            }
        }
        
    }
    return bufferDescriptor;
}

-(void)unloadFromGraphics{
    if(isLoadedToGraphicsCard){
        glDeleteBuffers(1, &normalsBuffer);
        glDeleteBuffers(1, &textureBuffer);
        glDeleteBuffers(1, &verticesBuffer);
        glDeleteVertexArrays(1, &vao);
    }
}

-(void)dealloc {
    [self unloadFromGraphics];
}

//amounts of vertices to draw vertex consists of 3 numbers x, y and z position
-(unsigned int)indiciesToDraw{
    return self->indiciesToDraw;
}
@end
