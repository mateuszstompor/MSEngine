//
//  MSTextureLoader.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 20/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import "MSTexture.h"

#ifndef MSTextureLoader_h
#define MSTextureLoader_h

@protocol MSTextureLoader
-(MSTexture*)loadTextureAtPath: (NSString*)pathToTexture;
@end

#endif /* MSTextureLoader_h */
