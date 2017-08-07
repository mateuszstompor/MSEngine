//
//  MSMathException.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 07/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef MSMathException_h
#define MSMathException_h

@interface MSMathException : NSException
@end

@interface MSMathDimensionMismatchException : MSMathException
@end

@interface MSMathIndexOutOfBounds : MSMathException
@end

#endif
