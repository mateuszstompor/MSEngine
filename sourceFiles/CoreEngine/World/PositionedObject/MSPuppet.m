//
//  MSpuppet.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 24/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSPuppet.h"


@implementation MSPuppet

-(instancetype)initWithScale: (MSMatrix4D*)scaleM rotation: (MSMatrix4D*)rotationM translation:(MSMatrix4D*)trM model: (NSArray<MSModelFraction*>*)mod{
    self=[super initWithScale:scaleM rotation:rotationM translation:trM];
    if(self){
        self->model=mod;
    }
    return self;
}
-(NSArray<MSModelFraction*>*)getModelComponents{
    return model;
}
-(instancetype)initWithModel: (NSArray<MSModelFraction*>*)md{
    self=[self initWithScale:[MSMatrixND identityMatrix:4] rotation:[MSMatrixND identityMatrix:4] translation:[MSMatrixND identityMatrix:4] model:md];
    return self;
}
//-(void)loadDataToGraphicsCard{
//    glGenBuffers(1, &dataVBO);
//    glGenBuffers(1, &orderEBO);
//    glGenVertexArrays(1, &verticiesVAO);
//    glBindVertexArray(verticiesVAO);
//    [self loadVerticiesToGraphics];
//    [self loadOrderOfVerticiesToGraphics];
//    glBindVertexArray(0);
//}
//-(void)loadVerticiesToGraphics{
//    glBindBuffer(GL_ARRAY_BUFFER, dataVBO);
//    unsigned long long sizeOfData=3*(int)[[model objectAtIndex:0] amountOfVerts];
//    glBufferData(GL_ARRAY_BUFFER, sizeOfData*sizeof(float), NULL, GL_STATIC_DRAW);
//    float* buffer = glMapBuffer(GL_ARRAY_BUFFER, GL_READ_WRITE);
//    [[model objectAtIndex:0] parseVertsToArray:buffer];
//    if(glUnmapBuffer(GL_ARRAY_BUFFER)==false){
//        [NSException raise:@"Cannot unmap array buffer!"
//                    format:@""];
//    }
//}
//-(void)loadOrderOfVerticiesToGraphics{
//    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, orderEBO);
//    unsigned long long amountOfFaces = [[model objectAtIndex:0] amountOfTriangleElements];
//    glBufferData(GL_ELEMENT_ARRAY_BUFFER, amountOfFaces*sizeof(GLuint), NULL, GL_STATIC_DRAW);
//    GLuint* bufElem= glMapBuffer(GL_ELEMENT_ARRAY_BUFFER, GL_WRITE_ONLY);
//    [[model objectAtIndex:0] parseOrderOfVertsToArray:bufElem];
//    if(glUnmapBuffer(GL_ELEMENT_ARRAY_BUFFER)==false){
//        [NSException raise:@"Cannot unmap element buffer!"
//                    format:@""];
//    }
//}
//-(GLuint)getVerticiesVAO{
//    return verticiesVAO;
//}
//-(GLuint)getElementsOrderBuffer{
//    return orderEBO;
//}
//-(GLuint)getBuffer{
//    return dataVBO;
//}
@end
