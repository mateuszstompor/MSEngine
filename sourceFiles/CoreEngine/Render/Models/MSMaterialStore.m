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
    }
    return self;
}
-(void)addMaterial: (MSMaterial*) material{
    [availableMaterials setObject:material forKey:[material name]];
}
-(int)amountOfMaterials{
    return (int)[availableMaterials count];
}
-(BOOL)hasMaterial: (NSString*) material{
    return [availableMaterials objectForKey:material] != nil ? true : false;
}
-(MSMaterial*)getMaterialWithName: (NSString*) nameOfMaterial{
    return [availableMaterials objectForKey:nameOfMaterial];
}
@end
