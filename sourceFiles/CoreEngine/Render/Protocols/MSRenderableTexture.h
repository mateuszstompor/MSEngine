//
//  MSRenderableTexture.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 12/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#ifndef MSRenderableTexture_h
#define MSRenderableTexture_h

@protocol MSRenderableTexture

@optional
-(void) deallocateFromGraphicsMemory;

@required
-(NSString*) name;
-(void) loadToGraphicsMemory;
-(BOOL) isLoadedToGraphicsMemory;
-(void) bindItself;

@end

#endif /* MSRenderableTexture_h */
