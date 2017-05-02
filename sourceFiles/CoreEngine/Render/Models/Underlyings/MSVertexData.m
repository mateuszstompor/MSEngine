//
//  MSVertexData.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#include "MSVertexData.h"

@implementation MSVertexData

-(instancetype)initWithIndexOfVertex: (unsigned int)vIndex NormalIndex: (unsigned int)nIndex{
    self=[super init];
    if(self){
        self->indexOfNormal=nIndex;
        self->indexOfVertex=vIndex;
    }
    return self;
}
-(unsigned int)getVertexIndex{
    return self->indexOfVertex;
}
-(unsigned int)getNormalIndex{
    return self->indexOfNormal;
}
-(void)print{
    printf("%iu %iu", indexOfVertex,indexOfNormal);
    printf("\n");
    fflush(stdout);
}
@end
