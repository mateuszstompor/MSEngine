//
//  MSResourcesHandlerOpenGL.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 12/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSResourcesHandlerOpenGL.h"

@implementation MSResourcesHandlerOpenGL

-(MSTextureOpenGL*)renderableTextureFrom: (MSTexture*) texture shouldLoad: (BOOL) should{
    return [[MSTextureOpenGL alloc] initFromTexture:texture withLoadingToGraphics:should];
}


@end
