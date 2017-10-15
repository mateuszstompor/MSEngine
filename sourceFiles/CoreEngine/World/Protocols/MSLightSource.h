//
//  MSLightSource.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 14/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import "MSLight.h"

#ifndef MSLightSource_h
#define MSLightSource_h

@protocol MSLightSource
-(id<MSLight>)getLight;
@end
#endif /* MSLightSource_h */
