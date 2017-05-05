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
    //[self loadVerticiesToGraphics];
    //[self loadNormalsToGraphics];
    glBindVertexArray(0);
}
//-(void)loadVerticiesToGraphics{
//    glBindVertexArray(verticiesVAO);
//    glGenBuffers(1, &dataVBO);
//    glBindBuffer(GL_ARRAY_BUFFER, dataVBO);
//    unsigned long long sizeOfData=(int)[self amountOfVerts];
//    //printf("number of verts is %llu, so i need %llu places for them\n",sizeOfData,3*sizeOfData);
//    glBufferData(GL_ARRAY_BUFFER, 3*2*sizeOfData*sizeof(float), NULL, GL_STATIC_DRAW);
//    float* buffer = glMapBuffer(GL_ARRAY_BUFFER, GL_READ_WRITE);
//    [self parseVertsToArray:buffer];
//    if(glUnmapBuffer(GL_ARRAY_BUFFER)==false){
//        [NSException raise:@"Cannot unmap array buffer!"
//                    format:@""];
//    }
//    glBindVertexArray(0);
//}
//-(void)loadNormalsToGraphics{
//    glBindVertexArray(verticiesVAO);
//    glBindBuffer(GL_ARRAY_BUFFER, dataVBO);
//    unsigned long long sizeOfData=3*(int)[self amountOfVerts];
//    //printf("number of verts is %llu, so i need %llu places for them\n",sizeOfData,3*sizeOfData);
//    float* buffer = glMapBuffer(GL_ARRAY_BUFFER, GL_READ_WRITE);
//    [self parseNormalsToArray:buffer+sizeOfData];
//    if(glUnmapBuffer(GL_ARRAY_BUFFER)==false){
//        [NSException raise:@"Cannot unmap array buffer!"
//                    format:@""];
//    }
//    glBindVertexArray(0);
//}
-(GLuint)getVerticiesVAO{
    [self loadIfIsNot];
    return verticiesVAO;
}
-(GLuint)getBuffer{
    [self loadIfIsNot];
    return dataVBO;
}
//-(void)parseVertsToArray: (float*)tab{
//    unsigned int currentIndex=0;
//    unsigned int amountOfVerts=(int)[vertices count];
//    while(currentIndex<amountOfVerts){
//        unsigned int indexToWrite=3*currentIndex;
//        memcpy((tab+indexToWrite), [(MSPoint*)[vertices objectAtIndex:currentIndex] getComponents], 3*sizeof(float));
//        currentIndex+=1;
//    }
//}

-(long long)amountOfElemntsToLoadToGraphics{
    return [facesData count];
}
-(void)loadVerticesAndNormals{
    glBindVertexArray(verticiesVAO);
    glGenBuffers(1, &dataVBO);
    glBindBuffer(GL_ARRAY_BUFFER, dataVBO);
    unsigned long long sizeOfData=(unsigned long long)3*3*2*[self amountOfElemntsToLoadToGraphics];
    glBufferData(GL_ARRAY_BUFFER, sizeOfData*sizeof(float), NULL, GL_STATIC_DRAW);
    float* buffer = glMapBuffer(GL_ARRAY_BUFFER, GL_READ_WRITE);
    [self parseDataToArray:buffer];
    if(glUnmapBuffer(GL_ARRAY_BUFFER)==false){
        [NSException raise:@"Cannot unmap array buffer!"
                    format:@""];
    }
    glBindVertexArray(0);
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


//-(void)parseNormalsToArray: (float*)tab{
//    unsigned int currentIndex=0;
//    unsigned int amountOfVerts=(int)[vertices count];
//    unsigned int sizeOfBothArrays = (GLuint)[self amountOfTriangleElements];
//    
//    GLuint orderOfNormals[sizeOfBothArrays];
//    GLuint orderOfVerts[sizeOfBothArrays];
//    [self parseOrderOfNormalsToArray:orderOfNormals];
//    [self parseOrderOfVertsToArray:orderOfVerts];
// 
//    
//    if([normals count]>0){
//        while(currentIndex<amountOfVerts){
//            unsigned int indexToWrite=orderOfVerts[currentIndex];
//            memcpy((tab+indexToWrite), [(MSPoint*)[normals objectAtIndex:orderOfNormals[currentIndex]] getComponents], 3*sizeof(float));
//            currentIndex+=1;
//        }
//    }
//}
//-(int)amountOfTriangleElements{
//    int i=0;
//    for(MSModelFace* face in facesData){
//        i+=[[face getFaceData] count];
//    }
//    return i;
//}
//-(NSString*)getName{
//    return self->name;
//}
//-(void)parseOrderOfVertsToArray: (GLuint*)tab{
//    GLuint i=0;
//    for(MSModelFace* face in facesData){
//        for(MSVertexData* dat in [face getFaceData]){
//            *(tab+i)=(GLuint)[dat getVertexIndex];
//            i+=1;
//        }
//    }
//}
//-(void)parseOrderOfNormalsToArray: (GLuint*)tab{
//    GLuint i=0;
//    for(MSModelFace* face in facesData){
//        for(MSVertexData* dat in [face getFaceData]){
//            *(tab+i)=(GLuint)[dat getNormalIndex];
//            i+=1;
//        }
//    }
//}
@end
