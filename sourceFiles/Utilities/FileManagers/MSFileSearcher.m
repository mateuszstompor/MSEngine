//
//  MSFileSearcher.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 13/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSFileSearcher.h"

@implementation MSFileSearcher

-(instancetype)initRecursiveSearcher: (unsigned int) amountOfLevelsToLookDownTheHierarchy{
    self=[super init];
    if(self){
        self->amountOfLevelsToSearch=amountOfLevelsToLookDownTheHierarchy;
        self->searchPaths = [[NSMutableArray alloc] init];
        self->manager = [NSFileManager defaultManager];
    }
    return self;
}

-(NSString*)pathForFile: (NSString*) fileName{
    for (NSString* path in self->searchPaths) {
        NSString* result = [self lookForFileAtPath:fileName path:path depth:self->amountOfLevelsToSearch];
        if(result != nil){
            return result;
        }
    }
    return nil;
}

-(BOOL)addSearchPath: (NSString*) folderPath{
    if ([manager fileExistsAtPath:folderPath]){
        for(NSString* path in searchPaths){
            if([path isEqualToString:folderPath]){
                return true;
            }
        }
        [searchPaths addObject:folderPath];
        return true;
    }
    return false;
}

-(BOOL)loadSearchPathsFromFile: (NSString*) fileName areRelative: (BOOL) relativeness {
    return false;
}

-(NSString*)lookForFileAtPath: (NSString*) file path: (NSString*) path depth: (unsigned int) depth {
    BOOL isDirectory;
    if([manager fileExistsAtPath:path isDirectory:&isDirectory]){
        if(!isDirectory){
            if([[manager displayNameAtPath:path] isEqualToString:file]){
                return path;
            }
        }
        else if (depth > 0){
                NSArray<NSString*>* contentsOfDict = [manager contentsOfDirectoryAtPath:path error:nil];
                for (NSString * fileInside in contentsOfDict){
                    NSString* pathToSearch = [path stringByAppendingFormat:@"/%@", fileInside];
                    NSString * result = [self lookForFileAtPath:file path:pathToSearch depth: depth-1];
                    if(result!=nil){
                        return result;
                    }
                }
        }
    }
    return nil;
}

@end
