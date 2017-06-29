//
//  MSVertexData.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#include "MSVertexData.h"

@implementation MSVertexData

-(instancetype)initWithIndexOfVertex: (unsigned int)vIndex normalIndex: (unsigned int)nIndex textureIndex: (unsigned int)tIndex{
    self=[super init];
    if(self){
        self->indexOfNormal=nIndex;
        self->indexOfVertex=vIndex;
        self->indexOfTextureCoord=tIndex;
    }
    return self;
}
-(unsigned int)getVertexIndex{
    return self->indexOfVertex;
}
-(unsigned int)getNormalIndex{
    return self->indexOfNormal;
}
-(unsigned int)getTextureCoordinateIndex{
    return self->indexOfTextureCoord;;
}
@end
