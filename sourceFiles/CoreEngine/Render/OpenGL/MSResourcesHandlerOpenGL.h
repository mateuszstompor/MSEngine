//
//  MSResourcesHandlerOpenGL.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 12/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSGraphicsResourcesHandler.h"
#import "MSTextureOpenGL.h"

@interface MSResourcesHandlerOpenGL : NSObject <MSGraphicsResourcesHandler>

-(MSTextureOpenGL*)renderableTextureFrom: (MSTexture*) texture shouldLoad: (BOOL) should;

@end
