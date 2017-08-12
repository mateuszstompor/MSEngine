//
//  MSGraphicsResourcesHandler.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 12/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MSTexture.h"
#import "MSRenderableTexture.h"

#ifndef MSGraphicsResourcesHandler_h
#define MSGraphicsResourcesHandler_h

@protocol MSGraphicsResourcesHandler

@required
-(id<MSRenderableTexture>)renderableTextureFrom: (MSTexture*) texture shouldLoad: (BOOL) should;

@end

#endif /* MSGraphicsResourcesHandler_h */
