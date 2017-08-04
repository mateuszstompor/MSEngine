//
//  macOSTests.m
//  macOSTests
//
//  Created by Mateusz Stompór on 08/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSLoaderOBJ.h"
#import "MSMatrixND.h"
#import "MSPuppet.h"
@interface macOSTests : XCTestCase
{
    MSMatrix4D* matrix;
    NSArray<MSModelFraction*>* model;
}
@end

@implementation macOSTests

- (void)setUp {
    [super setUp];
    matrix = [[MSMatrixND alloc] initWithIdentityMatrix:4];
}

- (void)tearDown {
    [super tearDown];
}
- (void)testObjectLoadingPerformance {
    [self measureBlock:^{
       model = [MSLoaderOBJ loadModel:"/Users/mateusz/Desktop/classroom.obj" tieWithMaterials:nil];
    }];
}
- (void)testMatrixMultiplicationPerformance{
    [self measureBlock:^{
        int i=0;
        while(i<400000){
            [[matrix multiplyByMatrix:matrix] matrixAsArray];
            ++i;
        }
    }];
}
@end
