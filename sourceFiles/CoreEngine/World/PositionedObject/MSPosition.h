//
//  MSPosition.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 08/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSMatrixND.h"

@interface MSPosition : NSObject
{
    @protected
    MSMatrixND* modelScale;
    MSMatrixND* modelRotation;
    MSMatrixND* modelTranslation;
    int dimension;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithDimension: (int)dimension;
-(MSMatrixND*)translateModelBy: (MSMatrixND*) tr;
-(MSMatrixND*)rotateModelBy: (MSMatrixND*) rot;
-(MSMatrixND*)scaleModelBy:(MSMatrixND*) sc;
-(MSMatrixND*)modelTranslation;
-(MSMatrixND*)modelRotation;
-(MSMatrixND*)modelScale;

@end
