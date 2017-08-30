//
//  MSLoaderMTL.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSMaterialStore.h"

#ifndef MSLOADERMTL_H
#define MSLOADERMTL_H

@interface MSLoaderMTL : NSObject
+(NSArray<MSMaterial*>*)loadMaterials: (NSString*)path;
+(instancetype)alloc;
@end


typedef NS_ENUM(NSUInteger, MSMTLEventType) {
    MTL_COMMENT,
    NEW_MATERIAL,
    AMBIENT,
    DIFFUSE,
    SPECULAR_COLOR,
    SHININESS,
    REFRACTION,
    TRANSPARENCY,
    RENDER_MODE,
    EMISSIVE,
    MAP_DIFFUSE,
    SKIP
};

#endif
