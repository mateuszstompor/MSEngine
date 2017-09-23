//
//  MSVertexData.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#include "MSVertexData.h"
#import "RedBlackTree.h"

@implementation MSVertexData

-(instancetype)initWithIndexOfVertex: (unsigned int)vIndex normalIndex: (unsigned int)nIndex textureIndex: (unsigned int)tIndex{
    self=[super init];
    if(self){
        RedBlackTree<NSObject*>* tree = [[RedBlackTree alloc] initWithComparingBlock:^(NSObject* a, NSObject* b){return 0;}];
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
