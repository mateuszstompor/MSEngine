//
//  MSMaterialStore.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSMaterial.h"
#import "MSTexture.h"

#ifndef MSMATERIALSTORE_H
#define MSMATERIALSTORE_H
@interface MSMaterialStore : NSObject

{
    @protected
    NSMutableDictionary<NSString*, MSMaterial*>* availableMaterials;
    NSMutableDictionary<NSString*, MSTexture*>* availableTextures;
}

@property (atomic) NSString* name;

-(instancetype)init;
-(void)addMaterial: (MSMaterial*) material;
-(void)addMaterials: (NSArray<MSMaterial*>*) materials;
-(void)addTexture: (MSTexture*) material;
-(void)addTextures: (NSArray<MSTexture*>*) textures;
-(MSMaterial*)getMaterialWithName: (NSString*) name;
-(MSTexture*)getTextureWithName: (NSString*) name;

-(int)amountOfMaterials;

@end
#endif
