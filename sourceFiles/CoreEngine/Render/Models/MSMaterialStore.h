//
//  MSMaterialStore.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSMaterial.h"


#ifndef MSMATERIALSTORE_H
#define MSMATERIALSTORE_H
@interface MSMaterialStore : NSObject
{
    NSString* name;
    NSMutableDictionary<NSString*,MSMaterial*>* availableMaterials;
}
-(instancetype)init;
-(void)setStoreName: (NSString*) name;
-(NSString*)getStoreName;
-(void)addMaterial: (MSMaterial*) material;
-(BOOL)hasMaterial: (NSString*) material;
-(MSMaterial*)getMaterialWithName: (NSString*) name;
-(int)amountOfMaterials;
@end
#endif
