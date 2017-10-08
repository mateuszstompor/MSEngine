//
//  MSModelFraction.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSModelFraction.h"
#import "MSMatrixND.h"
#import "MSModelTransform.h"

@implementation MSModelFraction
{
    MSModelTransform* transformation;
}
@synthesize materialName;
@synthesize name;
@synthesize vertices;
@synthesize normals;
@synthesize facesData;
@synthesize textureCoordinates;

-(instancetype)init{
    self=[super init];
    if(self){
        self->vertices=[[NSMutableArray alloc]init];
        self->normals=[[NSMutableArray alloc]init];
        self->facesData=[[NSMutableArray alloc]init];
        self->textureCoordinates=[[NSMutableArray alloc] init];
        self->name=nil;
        self->materialName=nil;
        self->_uniqueID=[NSValue valueWithNonretainedObject:self];
        self->transformation = [[MSModelTransform alloc] initWithDimension:4];
    }
    return self;
}
-(NSValue*)getUniqueName{
    return self->_uniqueID;
}

-(float*)parsePointsToArray: (NSArray<MSPoint*>*) data feedingFunction: (SEL) feedingFunction buffer: (float*) buf {
    unsigned int writeIndex=0;
    if([data  count] > 0){
        int dim = [[data objectAtIndex:0] getDimension];
        for(MSModelFace* face in [self facesData]){
            for(MSVertexData* dat in [face getFaceData]){
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                unsigned int readIndex = (unsigned int)[dat performSelector:feedingFunction withObject:nil];
    #pragma clang diagnostic pop
                memcpy(buf+writeIndex, [[data objectAtIndex: readIndex] getComponents], dim*sizeof(float));
                writeIndex+=dim;
            }
        }
    }
    return (buf+writeIndex);
}

-(MSModelTransform*) getTransformation {
    return self->transformation;
}
@end
