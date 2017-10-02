//
//  MSLoader.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 20/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSLoader.h"
#import "MSTextureLoaderBMP.h"
#import "MSFileSearcher.h"
#import "MSLoaderOBJ.h"
#import "MSLoaderMTL.h"
#import "MSModelFraction.h"
#import "MSTexture.h"

@implementation MSLoader
{
@protected
    MSFileSearcher* searcher;
}
-(instancetype)initRecursiveSearcher: (unsigned int) levelsToSearch{
    self=[super init];
    if(self){
        self->searcher = [[MSFileSearcher alloc] initRecursiveSearcher:levelsToSearch];
    }
    return self;
}
-(void)addSearchPath: (NSString*) path{
    [self->searcher addSearchPath:path];
}
-(NSArray<MSModelFraction*>*)loadModel: (NSString*) fileName{
    NSArray<MSModelFraction*>* arrayToReturn = nil;
    NSString* pathToFile = [self->searcher pathForFile:fileName];
    if(pathToFile!=nil){
        arrayToReturn = [MSLoaderOBJ loadModel:pathToFile];
    }
    return arrayToReturn;
}
-(NSArray<MSTexture*>*)loadTexturesForMaterials: (NSArray<MSMaterial*>*) materials{
    NSMutableArray<MSTexture*>* textures = [[NSMutableArray alloc] init];
    for (MSMaterial* mat in materials){
        if ([mat associatedTextureName] != nil) {
            NSString* pathToFile = [searcher pathForFile:[mat associatedTextureName]];
            if (pathToFile != nil){
                [textures addObject:[MSTextureLoaderBMP loadTextureAtPath:pathToFile itsName:[mat associatedTextureName]]];
            }
        }
    }
    return textures;
}
-(NSArray<MSMaterial*>*)loadMaterials: (NSString*) fileName{
    NSString* pathToFile = [self->searcher pathForFile:fileName];
    if(pathToFile!=nil){
        return [MSLoaderMTL loadMaterials:pathToFile];
    }
    return nil;
}
@end
