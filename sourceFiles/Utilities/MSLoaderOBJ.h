//
//  MSLoaderOBJ.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSModelManager.h"

#ifndef MSLOADER_H
#define MSLOADER_H
@interface MSLoaderOBJ : NSObject <MSModelManager>

   

+(NSArray<MSModelFraction*>*)loadModel: (const char*)path;
@end

typedef NS_ENUM(NSUInteger, MSOBJEventType) {
    COMMENT,
    OBJECT,
    VERTEX,
    NORMAL,
    TEXTURE,
    S,
    FACE,
    FILEEND,
    ERROR
};
#endif
