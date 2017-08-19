//
//  MSLoaderOBJ.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSMaterialStore.h"
#import "MSModelFraction.h"

#ifndef MSLOADER_H
#define MSLOADER_H

@interface MSLoaderOBJ : NSObject

+ (instancetype)alloc NS_UNAVAILABLE;
+(NSArray<MSModelFraction*>*)loadModel: (NSString*)path;

@end

typedef NS_ENUM(NSUInteger, MSOBJEventType) {
    OBJ_COMMENT,
    OBJECT,
    VERTEX,
    NORMAL,
    TEXTURE,
    S,
    FACE,
    FILEEND,
    ERROR,
    MATERIAL_LIB,
    USEMATERIAL
};

#endif
