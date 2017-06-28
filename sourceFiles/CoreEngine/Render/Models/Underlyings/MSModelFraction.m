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
        self->vertices=[[NSMutableArray alloc]init];
        self->normals=[[NSMutableArray alloc]init];
        self->facesData=[[NSMutableArray alloc]init];
        self->textureCoordinates=[[NSMutableArray alloc] init];
        self->name=[[NSString alloc]initWithUTF8String:""];
        self->fractionColor=[[MSVectorND alloc] initZeroVecWithDimension:3];
        self->isLoadedToGraphics=false;
        self->dataVBO=0;
        self->verticiesVAO=0;
        self->material=nil;
        [self generateRandomColor];
    }
    return self;
}
-(void)addVertex: (MSPoint3D*)point{
    [vertices addObject:point];
}
-(MSMaterial*)getMaterial{
    return self->material;
}
-(void)setMaterial: (MSMaterial*)mat{
    self->material=mat;
}
-(float*)getColor{
    if(material!=nil){
        return [[material diffuse] getArrayStyleVector];
    }else{
        return [fractionColor getArrayStyleVector];
    }
}
-(void)addNormal: (MSPoint3D*)point{
    [normals addObject:point];
}
-(void)addTextureCoordinate: (MSPoint2D*)point{
    [textureCoordinates addObject:point];
}
-(void)addFace: (MSModelFace*)face{
    [facesData addObject:face];
}
-(void)printVerts{
    for(MSPoint3D* p in vertices){
        [p printPoint];
    }
}
-(void)loadIfIsNot{
    if(isLoadedToGraphics==false){
        isLoadedToGraphics=true;
        [self loadDataToGraphicsCard];
    }
}
-(NSUInteger)amountOfTextureCoordinates{
    return [textureCoordinates count];
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
    for(int i=0; i<[fractionColor getDimension]; ++i){
        float color=((float)arc4random_uniform(randomNumberBound))/((float)randomNumberBound);
        [fractionColor setValueAtIdenx:i value:color];
    }
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
-(long) amountOfComponentsInsideEachFace {
    return [self amountOfNormalsPoints]+[self amountOfVerticesPoints];
}
-(long)amountOfNormalsPoints{
    return 3*3;
}
-(long)amountOfVerticesPoints{
    return 3*3;
}
-(void)loadVerticesAndNormals{
    glGenBuffers(1, &dataVBO);
    glBindBuffer(GL_ARRAY_BUFFER, dataVBO);
    unsigned long long sizeOfData=(unsigned long long)[self amountOfComponentsInsideEachFace]*[self amountOfElemntsToLoadToGraphics];
    glBufferData(GL_ARRAY_BUFFER, sizeOfData*sizeof(float), NULL, GL_STATIC_DRAW);
   
    float* buffer = glMapBufferRange(GL_ARRAY_BUFFER, 0,
                                     (unsigned long long)[self amountOfComponentsInsideEachFace]*[self amountOfElemntsToLoadToGraphics]
                                     , GL_MAP_WRITE_BIT);
    
    
    [self parseDataToArray:buffer];
    glBindVertexArray(0);
}
-(NSString*)getName{
    return self->name;
}
-(void)parseDataToArray: (float*)tab{
    unsigned long long currentIndex=0;
    unsigned long long amountOfElements = [self amountOfElemntsToLoadToGraphics];
    unsigned long long amountOfComponentsInsideEachFace = [self amountOfComponentsInsideEachFace];
    while(currentIndex<amountOfElements){
        unsigned long long indexToWrite=amountOfComponentsInsideEachFace*currentIndex;
        int verticesInFace = 3;
        for (int vertIndex = 0; vertIndex<verticesInFace; ++vertIndex){
            unsigned long long vIndex = [[[[facesData objectAtIndex:currentIndex] getFaceData]
                                          objectAtIndex:vertIndex]getVertexIndex];
            unsigned long long nIndex = [[[[facesData objectAtIndex:currentIndex] getFaceData]
                                          objectAtIndex:vertIndex]getNormalIndex];
            memcpy((tab+indexToWrite+2*vertIndex*verticesInFace),
                   [(MSPoint*)[vertices objectAtIndex:vIndex] getComponents], verticesInFace*sizeof(float));
            memcpy((tab+indexToWrite+2*vertIndex*verticesInFace+verticesInFace),
                   [(MSPoint*)[normals objectAtIndex:nIndex] getComponents], verticesInFace*sizeof(float));

        }
        currentIndex+=1;
    }
}
-(void)dealloc{
    NSLog(@"dealloc");
    if(isLoadedToGraphics==true){
        glDeleteBuffers(1, &dataVBO);
        glDeleteVertexArrays(1, &verticiesVAO);
    }
}
@end
