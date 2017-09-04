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

@required
-(NSString*) name;
-(instancetype)initFromTexture: (MSTexture*) texture;
-(unsigned int)getUniqueID;
@end

#endif /* MSRenderableTexture_h */
