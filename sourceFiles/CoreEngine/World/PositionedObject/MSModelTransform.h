//
//  MSModelTransform.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 08/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSMatrixND.h"

#ifndef MSModelTransform_h
#define MSModelTransform_h

@interface MSModelTransform : NSObject
{
    int dimension;
    MSMatrixND* modelScale;
    MSMatrixND* modelRotation;
    MSMatrixND* modelTranslation;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithDimension: (int) dimension;
-(void)translateBy: (MSVectorND*) vector;
-(void)rotateByAngleInRadians: (float) x y: (float) y z: (float) z;
-(void)scaleBy:(MSVectorND*) sc;
-(MSMatrixND*)translateModelBy: (MSMatrixND*) tr;
-(MSMatrixND*)rotateModelBy: (MSMatrixND*) rot;
-(MSMatrixND*)scaleModelBy:(MSMatrixND*) sc;
-(MSVectorND*)right;
-(MSVectorND*)direction;
-(MSMatrixND*)modelScale;
-(MSMatrixND*)modelRotation;
-(MSMatrixND*)modelTranslation;

@end

#endif
