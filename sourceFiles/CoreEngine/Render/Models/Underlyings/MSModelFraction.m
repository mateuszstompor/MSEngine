//
//  MSModelFraction.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSModelFraction.h"

@implementation MSModelFraction

@synthesize material;
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
        self->material=nil;
        self->_uniqueName=[NSValue valueWithNonretainedObject:self];
    }
    return self;
}
-(NSValue*)getUniqueName{
    return self->_uniqueName;
}
@end
