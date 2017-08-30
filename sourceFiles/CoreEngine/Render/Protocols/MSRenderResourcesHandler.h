//
//  MSRenderResourcesHandler.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 30/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSRenderableTexture.h"

#ifndef MSRenderResourcesHandler_h
#define MSRenderResourcesHandler_h

@protocol MSRenderResourcesHandler

@required

-(id<MSRenderableTexture>)getRenderableTextureForName: (NSString*) name;

@end

#endif
