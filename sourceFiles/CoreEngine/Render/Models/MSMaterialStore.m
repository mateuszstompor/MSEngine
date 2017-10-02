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

-(instancetype)init{
    self = [super init];
    if(self != nil){
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
    [availableTextures setObject: texture forKey:[texture getName]];
}
-(int)amountOfMaterials{
    return (int)[availableMaterials count];
}
-(void)addMaterials: (NSArray<MSMaterial*>*) materials{
    for(MSMaterial* mat in materials){
        [self addMaterial:mat];
    }
}
-(void)addTextures: (NSArray<MSTexture*>*) textures {
    for(MSTexture* tex in textures){
        [self addTexture:tex];
    }
}
-(MSTexture*)getTextureWithName: (NSString*) textureName{
    return [availableTextures objectForKey:textureName];
}
-(MSMaterial*)getMaterialWithName: (NSString*) nameOfMaterial{
    return [availableMaterials objectForKey:nameOfMaterial];
}
@end
