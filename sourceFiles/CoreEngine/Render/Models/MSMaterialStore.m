//
//  MSMaterialStore.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSMaterialStore.h"
@implementation MSMaterialStore

@synthesize name;

-(instancetype)initWithGraphicsHandler: (id<MSGraphicsResourcesHandler>) graphicsHandler{
    self = [super init];
    if(self != nil){
        self->handler=graphicsHandler;
        self->name=nil;
        self->availableMaterials=[[NSMutableDictionary alloc]init];
        self->availableTextures=[[NSMutableDictionary alloc]init];
    }
    return self;
}

-(void)addMaterial: (MSMaterial*) material{
    [availableMaterials setObject:material forKey:[material name]];
}
-(void)addTexture: (MSTexture*) texture{
    id<MSRenderableTexture> renderableTexture = [handler renderableTextureFrom:texture shouldLoad:true];
    [availableTextures setObject: renderableTexture forKey:[renderableTexture name]];
}
-(int)amountOfMaterials{
    return (int)[availableMaterials count];
}
-(id<MSRenderableTexture>)getTextureWithName: (NSString*) textureName{
    return [availableTextures objectForKey:textureName];
}
-(MSMaterial*)getMaterialWithName: (NSString*) nameOfMaterial{
    return [availableMaterials objectForKey:nameOfMaterial];
}
@end
