//
//  iOSTests.m
//  iOSTests
//
//  Created by Mateusz Stompór on 08/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSMatrixND.h"
@interface iOSTests : XCTestCase
{
    MSMatrix4D* matrix;
}
@end

@implementation iOSTests

- (void)setUp {
    [super setUp];
    matrix = [[MSMatrixND alloc] initWithIdentityMatrix:4];
}

- (void)tearDown {
    [super tearDown];
}
- (void)testMatrixMultiplicationPerformance{
    [self measureBlock:^{
        int i=0;
        while(i<400){
            [[matrix multiplyByMatrix:matrix] matrixAsArray];
            ++i;
        }
    }];
}
@end
