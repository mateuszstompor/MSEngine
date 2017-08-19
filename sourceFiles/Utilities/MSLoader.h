//
//  MSLoader.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 20/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSFileSearcher.h"
#import "MSModelFraction.h"
#import "MSLoaderOBJ.h"
#import "MSLoaderMTL.h"
#import "MSResourcesHandlerOpenGL.h"

@interface MSLoader : NSObject
{
    @protected
    MSFileSearcher* searcher;
}
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initRecursiveSearcher: (unsigned int) levelsToSearch;
-(void)addSearchPath: (NSString*) path;
-(NSArray<MSModelFraction*>*)loadModel: (NSString*) fileName;
-(MSMaterialStore*)loadMaterials: (NSString*) fileName;
@end
