//
//  MSLoader.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 20/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSLoader.h"

@implementation MSLoader
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
-(MSMaterialStore*)loadMaterials: (NSString*) fileName{
    MSMaterialStore* materialsToReturn = nil;
    NSString* pathToFile = [self->searcher pathForFile:fileName];
    if(pathToFile!=nil){
        
        materialsToReturn = [MSLoaderMTL loadMaterials:pathToFile handler:[[MSResourcesHandlerOpenGL alloc] init]];
    }
    return materialsToReturn;
}
@end
