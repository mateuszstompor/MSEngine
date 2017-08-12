//
//  MSLoaderMTL_Tests.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 12/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSLoaderMTL.h"

@interface MSLoaderMTL_Tests : XCTestCase
{
    MSMaterialStore* store;
}
@end

@implementation MSLoaderMTL_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    store = [MSLoaderMTL loadMaterials:"/Users/mateusz/Desktop/graphics/classroomWithMaterials/classroom.mtl"];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
