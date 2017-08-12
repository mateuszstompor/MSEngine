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
#import "MSRenderableTexture.h"
#import "MSGraphicsResourcesHandler.h"

#ifndef MSMATERIALSTORE_H
#define MSMATERIALSTORE_H
@interface MSMaterialStore : NSObject

{
    @protected
    NSMutableDictionary<NSString*,MSMaterial*>* availableMaterials;
    NSMutableDictionary<NSString*,id<MSRenderableTexture>>* availableTextures;
    id<MSGraphicsResourcesHandler> handler;
}

@property (atomic) NSString* name;

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithGraphicsHandler: (id<MSGraphicsResourcesHandler>) handler;
-(void)addMaterial: (MSMaterial*) material;
-(void)addTexture: (MSTexture*) material;
-(MSMaterial*)getMaterialWithName: (NSString*) name;
-(id<MSRenderableTexture>)getTextureWithName: (NSString*) name;

-(int)amountOfMaterials;

@end
#endif
