//
//  MSFileSearcher.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 13/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSFileSearcher : NSObject

{
    @protected
    NSMutableArray<NSString*>* searchPaths;
    NSFileManager* manager;
    unsigned int amountOfLevelsToSearch;
}

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initRecursiveSearcher: (unsigned int) amountOfLevelsToLookDownTheHierarchy;
-(NSString*)pathForFile: (NSString*) fileName;
-(BOOL)addSearchPath: (NSString*) folderPath;
-(BOOL)loadSearchPathsFromFile: (NSString*) fileName areRelative: (BOOL) relativeness;
-(NSString*)lookForFileAtPath: (NSString*) file path: (NSString*) path depth: (unsigned int) depth;

@end
