//
//  MSModelFraction.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSModelFraction.h"

@implementation MSModelFraction
-(instancetype)init{
    self=[super init];
    if(self){
        vertices=[[NSMutableArray alloc]init];
        normals=[[NSMutableArray alloc]init];
        facesData=[[NSMutableArray alloc]init];
        self->name=[[NSString alloc]initWithUTF8String:""];
        self->fractionColor=[[MSVectorND alloc] initZeroVecWithDimension:3];
        isLoadedToGraphics=false;
        [self generateRandomColor];
    }
    return self;
}
-(void)addVertex: (MSPoint*)point{
    [vertices addObject:point];
}
-(float*)getColor{
    return [fractionColor getArrayStyleVector];
}
-(void)addNormal: (MSPoint*)point{
    [normals addObject:point];
}
-(void)addFace: (MSModelFace*)face{
    [facesData addObject:face];
}
-(void)printVerts{
    for(MSPoint* p in vertices){
        [p printPoint];
    }
}
-(void)loadIfIsNot{
    if(isLoadedToGraphics==false){
        isLoadedToGraphics=true;
        [self loadDataToGraphicsCard];
    }
}
-(NSUInteger)amountOfVerts{
    return [vertices count];
}
-(NSUInteger)amountOfNormals{
    return [normals count];
}
-(void)setName: (NSString*)newName{
    self->name=newName;
}
-(void)generateRandomColor{
    unsigned int randomNumberBound=1000;
    float first=((float)arc4random_uniform(randomNumberBound))/((float)randomNumberBound);
    float second=((float)arc4random_uniform(randomNumberBound))/((float)randomNumberBound);
    float third=((float)arc4random_uniform(randomNumberBound))/((float)randomNumberBound);
    [fractionColor setValueAtIdenx:0 value:first];
    [fractionColor setValueAtIdenx:1 value:second];
    [fractionColor setValueAtIdenx:2 value:third];
    
}
-(void)loadDataToGraphicsCard{
    glGenVertexArrays(1, &verticiesVAO);
    glBindVertexArray(verticiesVAO);
    [self loadVerticesAndNormals];
    glBindVertexArray(0);
}
-(GLuint)getVerticiesVAO{
    [self loadIfIsNot];
    return verticiesVAO;
}
-(GLuint)getBuffer{
    [self loadIfIsNot];
    return dataVBO;
}
-(long long)amountOfElemntsToLoadToGraphics{
    return [facesData count];
}
-(void)loadVerticesAndNormals{
    glBindVertexArray(verticiesVAO);
    glGenBuffers(1, &dataVBO);
    glBindBuffer(GL_ARRAY_BUFFER, dataVBO);
    unsigned long long sizeOfData=(unsigned long long)3*3*2*[self amountOfElemntsToLoadToGraphics];
    glBufferData(GL_ARRAY_BUFFER, sizeOfData*sizeof(float), NULL, GL_STATIC_DRAW);
    #if macOS
    float* buffer = glMapBuffer(GL_ARRAY_BUFFER, GL_READ_WRITE);
    #endif
    #if iOS
    float* buffer = glMapBufferRange(GL_ARRAY_BUFFER, 0, (unsigned long long)3*3*2*[self amountOfElemntsToLoadToGraphics], GL_MAP_WRITE_BIT);
    #endif
    
    [self parseDataToArray:buffer];
//    if(glUnmapBuffer(GL_ARRAY_BUFFER)==false){
//        [NSException raise:@"Cannot unmap array buffer!"
//                    format:@""];
//    }
    glBindVertexArray(0);
}
-(NSString*)getName{
    return self->name;
}
-(void)parseDataToArray: (float*)tab{
    unsigned long long currentIndex=0;
    unsigned long long amountOfElements = [self amountOfElemntsToLoadToGraphics];
    while(currentIndex<amountOfElements){
        unsigned long long indexToWrite=2*3*3*currentIndex;
        unsigned long long indexOfVert1 = [[[[facesData objectAtIndex:currentIndex] getFaceData] objectAtIndex:0]getVertexIndex];
        unsigned long long indexOfNormal1 = [[[[facesData objectAtIndex:currentIndex] getFaceData] objectAtIndex:0]getNormalIndex];
        unsigned long long indexOfVert2 = [[[[facesData objectAtIndex:currentIndex] getFaceData] objectAtIndex:1]getVertexIndex];
        unsigned long long indexOfNormal2 = [[[[facesData objectAtIndex:currentIndex] getFaceData] objectAtIndex:1]getNormalIndex];
        unsigned long long indexOfVert3 = [[[[facesData objectAtIndex:currentIndex] getFaceData] objectAtIndex:2]getVertexIndex];
        unsigned long long indexOfNormal3 = [[[[facesData objectAtIndex:currentIndex] getFaceData] objectAtIndex:2]getNormalIndex];
        memcpy((tab+indexToWrite), [(MSPoint*)[vertices objectAtIndex:indexOfVert1] getComponents], 3*sizeof(float));
        memcpy((tab+indexToWrite+3), [(MSPoint*)[normals objectAtIndex:indexOfNormal1] getComponents], 3*sizeof(float));
        memcpy((tab+indexToWrite+6), [(MSPoint*)[vertices objectAtIndex:indexOfVert2] getComponents], 3*sizeof(float));
        memcpy((tab+indexToWrite+9), [(MSPoint*)[normals objectAtIndex:indexOfNormal2] getComponents], 3*sizeof(float));
        memcpy((tab+indexToWrite+12), [(MSPoint*)[vertices objectAtIndex:indexOfVert3] getComponents], 3*sizeof(float));
        memcpy((tab+indexToWrite+15), [(MSPoint*)[normals objectAtIndex:indexOfNormal3] getComponents], 3*sizeof(float));
        currentIndex+=1;
    }
}
@end
