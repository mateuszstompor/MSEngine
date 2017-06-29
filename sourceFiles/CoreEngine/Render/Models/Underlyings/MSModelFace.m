//
//  MSModelFace.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSModelFace.h"

@implementation MSModelFace
-(instancetype)initWithData: (int)amountOfVertexData, ... {
    self=[super init];
    if(self){
        associatedVertices=[[NSMutableArray alloc] init];
        va_list listOfComponents;
        va_start(listOfComponents, amountOfVertexData);
        for(int i=0; i<amountOfVertexData; i++){
            [associatedVertices addObject:(MSVertexData*)va_arg(listOfComponents, MSVertexData*)];
        }
        va_end(listOfComponents);
    }
    return self;
}
-(void)print{
    for(MSVertexData* dat in associatedVertices){
        [dat print];
    }
}
-(NSMutableArray<MSVertexData*>*)getFaceData{
    return self->associatedVertices;
}
@end
