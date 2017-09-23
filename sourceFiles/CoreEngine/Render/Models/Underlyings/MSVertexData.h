//
//  MSVertexData.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef MSVERTEXDATA_H
#define MSVERTEXDATA_H
@interface MSVertexData : NSObject
{
    unsigned int indexOfVertex;
    unsigned int indexOfNormal;
    unsigned int indexOfTextureCoord;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithIndexOfVertex: (unsigned int)vIndex normalIndex: (unsigned int)nIndex textureIndex: (unsigned int)tIndex;
-(unsigned int)getVertexIndex;
-(unsigned int)getNormalIndex;
-(unsigned int)getTextureCoordinateIndex;
@end
#endif
