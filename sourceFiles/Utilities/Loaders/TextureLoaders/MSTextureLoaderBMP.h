//
//  MSTextureLoaderBMP.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSTextureLoader.h"
#import <CoreGraphics/CoreGraphics.h>

#if iOS
#import <UIKit/UIKit.h>
#endif

#ifndef MSTextureLoaderBMP_h
#define MSTextureLoaderBMP_h

@interface MSTextureLoaderBMP : NSObject <MSTextureLoader>

+(MSTexture*)loadTextureAtPath: (NSString*)pathToTexture itsName: (NSString*) nam;
//+(MSTexture*)loadTextAtPath: (NSString*)path;
@end

#endif
