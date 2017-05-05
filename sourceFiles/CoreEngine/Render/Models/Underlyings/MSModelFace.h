//
//  MSModelFace.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSVertexData.h"

#ifndef MSMODELFACE_H
#define MSMODELFACE_H
@interface MSModelFace : NSObject
{
    NSMutableArray<MSVertexData*>* associatedVertices;
}
-(instancetype)init;
-(instancetype)initWithData: (int)amountOfVertexData,...;
-(NSMutableArray<MSVertexData*>*)getFaceData;
-(void)print;
@end
#endif
