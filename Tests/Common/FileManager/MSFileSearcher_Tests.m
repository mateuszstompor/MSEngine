//
//  MSFileSearcher_Tests.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 13/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSFileSearcher.h"

@interface MSFileSearcher_Tests : XCTestCase
{
    NSString* pathToSearchPathTest;
    MSFileSearcher* searcherNonRecursive;
    MSFileSearcher* searcherRecursive3Levels;
    NSFileManager* helper;
}
@end

@implementation MSFileSearcher_Tests

- (void)setUp {
    [super setUp];
    searcherRecursive3Levels = [[MSFileSearcher alloc] initRecursiveSearcher:3];
    searcherNonRecursive = [[MSFileSearcher alloc] initRecursiveSearcher:1];
    helper = [NSFileManager defaultManager];
    pathToSearchPathTest = @"/Users/mateuszstompor/Documents/MSEngine/Tests/Common/FileManager/SearchPathTest";
    [searcherNonRecursive addSearchPath:pathToSearchPathTest];
    [searcherRecursive3Levels addSearchPath:pathToSearchPathTest];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testRecursiveSearching {
    
    //#1
    NSString* result = [searcherNonRecursive lookForFileAtPath:@"testFile.txt" path:pathToSearchPathTest depth:1];
    XCTAssertNotNil(result);
    XCTAssertTrue([helper fileExistsAtPath:result]);
    
    //#2
    NSString* pathToTestFile = [pathToSearchPathTest stringByAppendingFormat:@"/testFile.txt"];
    result = [searcherNonRecursive lookForFileAtPath:@"testFile.txt" path: pathToTestFile depth:1];
    XCTAssertNotNil(result);
    XCTAssertTrue([helper fileExistsAtPath:result]);
    
    //#3
    result = [searcherNonRecursive lookForFileAtPath:@"testFile1.txt" path:pathToSearchPathTest depth:2];
    XCTAssertNotNil(result);
    XCTAssertTrue([helper fileExistsAtPath:result]);
    
    //#4
    result = [searcherNonRecursive lookForFileAtPath:@"testFile1.txt" path:pathToSearchPathTest depth:4];
    XCTAssertNotNil(result);
    XCTAssertTrue([helper fileExistsAtPath:result]);
    
    //#5
    result = [searcherNonRecursive lookForFileAtPath:@"testFile2.txt" path:pathToSearchPathTest depth:2];
    XCTAssertNil(result);
    
    //#6
    result = [searcherNonRecursive lookForFileAtPath:@"testFile2.txt" path:pathToSearchPathTest depth:3];
    XCTAssertNotNil(result);
    XCTAssertTrue([helper fileExistsAtPath:result]);
    
    //#7
    result = [searcherNonRecursive lookForFileAtPath:@"testFile3.txt" path:pathToSearchPathTest depth:3];
    XCTAssertNil(result);
    
    //#8
    result = [searcherNonRecursive lookForFileAtPath:@"testFile2.txt" path:pathToSearchPathTest depth:4];
    XCTAssertNotNil(result);
    XCTAssertTrue([helper fileExistsAtPath:result]);
}

-(void)testLookingForFileFromAddedSearchPathNonRecursive {
    //nonrecursive
    
    //#1
    XCTAssertTrue([searcherNonRecursive addSearchPath:pathToSearchPathTest]);
    
    //#2
    NSString* pathToTestFile = [pathToSearchPathTest stringByAppendingFormat:@"/testFile.txt"];
    XCTAssertTrue([searcherNonRecursive addSearchPath:pathToTestFile]);
    
    //#3
    NSString* path = [searcherNonRecursive pathForFile:@"testFile.txt"];
    XCTAssertNotNil(path);
    XCTAssertNil([searcherNonRecursive pathForFile:@"testFile2.txt"]);
    
    //#4
    NSString* pathToFolderInsideTestFolder = [pathToSearchPathTest stringByAppendingFormat:@"/level1/level2"];
    XCTAssertTrue([searcherNonRecursive addSearchPath:pathToFolderInsideTestFolder]);
    XCTAssertFalse([searcherNonRecursive addSearchPath:[pathToFolderInsideTestFolder stringByAppendingString:@"2"]]);
    XCTAssertNotNil([searcherNonRecursive pathForFile:@"testFile2.txt"]);
}

-(void)testLookingForFileFromAddedSearchPathRecursive {
    //nonrecursive
    
    //#1
    NSString* pathToFile;
    pathToFile = [searcherRecursive3Levels pathForFile:@"testFile.txt"];
    XCTAssertNotNil(pathToFile);
    XCTAssertTrue([helper fileExistsAtPath:pathToFile]);
    //#2
    pathToFile = [searcherRecursive3Levels pathForFile:@"testFile1.txt"];
    XCTAssertNotNil(pathToFile);
    XCTAssertTrue([helper fileExistsAtPath:pathToFile]);
    //#3
    pathToFile = [searcherRecursive3Levels pathForFile:@"testFile2.txt"];
    XCTAssertNotNil(pathToFile);
    XCTAssertTrue([helper fileExistsAtPath:pathToFile]);
    
    //#4
    pathToFile = [searcherRecursive3Levels pathForFile:@"testFile4.txt"];
    XCTAssertNil(pathToFile);
    
    //#5
    NSString* searchPath = [pathToSearchPathTest stringByAppendingString:@"/level1/level2/level3/level4"];
    XCTAssertTrue([searcherRecursive3Levels addSearchPath: searchPath]);
    
    //#6
    XCTAssertTrue([searcherRecursive3Levels addSearchPath:[searchPath stringByAppendingString:@"/"]]);
    
    //#7
    XCTAssertNotNil([searcherRecursive3Levels pathForFile:@"testFile4.txt"]);
}

@end
