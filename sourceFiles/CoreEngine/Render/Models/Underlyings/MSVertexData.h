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
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithIndexOfVertex: (unsigned int)vIndex NormalIndex: (unsigned int)nIndex;
-(unsigned int)getVertexIndex;
-(unsigned int)getNormalIndex;
-(void)print;
@end
#endif
