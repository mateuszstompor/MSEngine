//
//  MSTexture_Tests.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 12/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSTexture.h"

@interface MSTexture_Tests : XCTestCase
@property MSTexture* texture;
@property NSString* pathAtWhichCorrectFileExists;
@property NSString* pathAtWhichFileDoesntExists;
@property NSString* pathAtWhichCorrutedFileExists;
@end

@implementation MSTexture_Tests

- (void)setUp {
    [super setUp];
   // _pathAtWhichCorrectFileExists = @"/Users/mateusz/Desktop/MSEngine/MSGraphicsEngineTests_iOS/testAssets/test.bmp";
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInitializer {
    //XCTAssertNoThrow([[MSTexture alloc] initTextureFromFile:_pathAtWhichCorrectFileExists]);
   
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
