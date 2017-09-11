//
//  MSModelFraction.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSModelFraction.h"
#import "MSMatrixND.h"

@implementation MSModelFraction

@synthesize materialName;
@synthesize name;
@synthesize vertices;
@synthesize normals;
@synthesize facesData;
@synthesize textureCoordinates;
@synthesize modelScale;
@synthesize modelRotation;
@synthesize modelTranslation;

-(instancetype)init{
    self=[super init];
    if(self){
        self->vertices=[[NSMutableArray alloc]init];
        self->normals=[[NSMutableArray alloc]init];
        self->facesData=[[NSMutableArray alloc]init];
        self->textureCoordinates=[[NSMutableArray alloc] init];
        self->name=nil;
        self->materialName=nil;
        self->_uniqueName=[NSValue valueWithNonretainedObject:self];
        self->modelRotation = [MSMatrixND identityMatrix:4];
        self->modelScale = [MSMatrixND identityMatrix:4];
        self->modelTranslation = [MSMatrixND identityMatrix:4];
    }
    return self;
}
-(NSValue*)getUniqueName{
    return self->_uniqueName;
}
-(void)translateModelBy: (MSMatrixND*) tr{
    self->modelTranslation=[tr multiplyByMatrix:modelTranslation];
}
-(void)rotateModelBy: (MSMatrixND*) rot{
    self->modelRotation=[rot multiplyByMatrix:modelRotation];
}
-(void)scaleModelBy:(MSMatrixND*) sc{
    self->modelScale=[sc multiplyByMatrix:self->modelScale];
}

@end
