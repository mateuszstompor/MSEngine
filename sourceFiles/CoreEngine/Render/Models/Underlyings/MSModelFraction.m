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
    [self loadVerticiesToGraphics];
    [self loadOrderOfVerticiesToGraphics];
    glBindVertexArray(0);
}
-(void)loadVerticiesToGraphics{
    glBindVertexArray(verticiesVAO);
    glGenBuffers(1, &dataVBO);
    glBindBuffer(GL_ARRAY_BUFFER, dataVBO);
    unsigned long long sizeOfData=(int)[self amountOfVerts];
    printf("number of verts is %llu, so i need %llu places for them\n",sizeOfData,3*sizeOfData);
    glBufferData(GL_ARRAY_BUFFER, 3*sizeOfData*sizeof(float), NULL, GL_STATIC_DRAW);
    float* buffer = glMapBuffer(GL_ARRAY_BUFFER, GL_READ_WRITE);
    [self parseVertsToArray:buffer];
    if(glUnmapBuffer(GL_ARRAY_BUFFER)==false){
        [NSException raise:@"Cannot unmap array buffer!"
                    format:@""];
    }
    glBindVertexArray(0);
}
-(void)setAttrib: (GLuint)program{
    glBindVertexArray(verticiesVAO);
    GLuint pos = glGetAttribLocation(program, "position");
    glVertexAttribPointer(pos, 3, GL_FLOAT, GL_FALSE, 3*sizeof(GLfloat), 0);
    glEnableVertexAttribArray(pos);
    glBindFragDataLocation(program, 0, "outColor");
    glBindVertexArray(0);
}
-(void)loadOrderOfVerticiesToGraphics{
    glBindVertexArray(verticiesVAO);
    glGenBuffers(1, &orderEBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, orderEBO);
    unsigned long long amountOfFaces = [self amountOfTriangleElements];
    printf("number of faces is %llu\n",amountOfFaces);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, amountOfFaces*sizeof(GLuint), NULL, GL_STATIC_DRAW);
    GLuint* bufElem= glMapBuffer(GL_ELEMENT_ARRAY_BUFFER, GL_READ_WRITE);
    [self parseOrderOfVertsToArray:bufElem];
    if(glUnmapBuffer(GL_ELEMENT_ARRAY_BUFFER)==false){
        [NSException raise:@"Cannot unmap element buffer!"
                    format:@""];
    }
    glBindVertexArray(0);
}
-(GLuint)getVerticiesVAO{
    [self loadIfIsNot];
    return verticiesVAO;
}
-(GLuint)getElementsOrderBuffer{
    [self loadIfIsNot];
    return orderEBO;
}
-(GLuint)getBuffer{
    [self loadIfIsNot];
    return dataVBO;
}
-(void)parseVertsToArray: (float*)tab{
    unsigned int currentIndex=0;
    unsigned int amountOfVerts=(int)[vertices count];
    while(currentIndex<amountOfVerts){
        unsigned int indexToWrite=3*currentIndex;
        memcpy((tab+indexToWrite), [(MSPoint*)[vertices objectAtIndex:currentIndex] getComponents], 3*sizeof(float));
        currentIndex+=1;
    }
}
-(int)amountOfTriangleElements{
    int i=0;
    for(MSModelFace* face in facesData){
        i+=[[face getFaceData] count];
    }
    return i;
}
-(NSString*)getName{
    return self->name;
}
-(void)parseOrderOfVertsToArray: (GLuint*)tab{
    GLuint i=0;
    for(MSModelFace* face in facesData){
        for(MSVertexData* dat in [face getFaceData]){
            *(tab+i)=(GLuint)[dat getVertexIndex];
            i+=1;
        }
    }
}
@end
