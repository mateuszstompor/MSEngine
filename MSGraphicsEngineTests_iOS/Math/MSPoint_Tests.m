//
//  MSPoint_Tests.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 07/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSPoint.h"

@interface MSPoint_Tests : XCTestCase
{
    MSPoint* point;
    long testAmount;
}
@end

@implementation MSPoint_Tests

- (void)setUp {
    [super setUp];
    point = [[MSPoint alloc] initWithDimension: 3];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testIndexBound {
    XCTAssertThrows([point checkIndexBound:5]);
    XCTAssertNoThrow([point checkIndexBound:2]);
    XCTAssertNoThrow([point checkIndexBound:0]);
}
-(void)testSetGet {
    [point safeSetComponent:0 value:0.0f];
    [point safeSetComponent:1 value:2.0f];
    [point safeSetComponent:2 value:4.0f];
    for(int i=0; i<[point getDimension]; ++i){
        XCTAssertTrue([point safeGetComponent:i]==i*2);
    }
}
-(void)testInitializer {
    point = [[MSPoint alloc] initZeroPointWithDimension:3];
    for (int i=0; i<[point getDimension]; ++i){
        XCTAssertTrue(*([point getComponents]+i) == 0);
        XCTAssertTrue([point getComponent:i] == 0);
        XCTAssertTrue([point safeGetComponent:i] == 0);
    }
    point = [[MSPoint alloc] init2DimPointWithX:0.0f y:1.0f];
    XCTAssertTrue([point getDimension]==2);
    for (int i=0; [point getDimension]; ++i){
        XCTAssertTrue([point getComponent:i] == i);
    }
    point = [[MSPoint alloc] init3DimPointWithX:0.0f y:1.0f z:2.0f];
    XCTAssertTrue([point getDimension]==3);
    for (int i=0; [point getDimension]; ++i){
        XCTAssertTrue([point getComponent:i] == i);
    }
}
@end
