//
//  MSTransformationManager_Tests.m
//  macMSGraphicsEngineTests
//
//  Created by Mateusz Stompór on 16/09/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSVectorND.h"
#import "MSMatrixND.h"
#import "MSTransformationManager.h"

@interface MSTransformationManager_Tests : XCTestCase
{
    MSVectorND* vector;
}
@end

@implementation MSTransformationManager_Tests

- (void)setUp {
    [super setUp];
    vector = [MSVectorND onesVector:4];
}

-(void)testDegressToRadians {
    XCTAssertEqualWithAccuracy([MSTransformationManager radians:360], 2*M_PI, 0.001);
    XCTAssertEqualWithAccuracy([MSTransformationManager radians:0], 0, 0.001);
    XCTAssertEqualWithAccuracy([MSTransformationManager radians:180], M_PI, 0.001);
}

-(void)testRadiansToDegress {
    XCTAssertEqualWithAccuracy([MSTransformationManager degress:M_PI], 180, 0.001);
    XCTAssertEqualWithAccuracy([MSTransformationManager degress:M_PI_2], 90, 0.001);
    XCTAssertEqualWithAccuracy([MSTransformationManager degress:4*M_PI], 720, 0.001);
}

- (void)tearDown {
    [super tearDown];
}

-(void)testRotationZ {
    MSVectorND* result = [[MSTransformationManager rotationMatrixAboutZinRadians4x4:M_PI] multiplyByColumnVector:vector];
    XCTAssertEqualWithAccuracy([result valueAtIndex:0], -1.0f, 0.001);
    XCTAssertEqualWithAccuracy([result valueAtIndex:1], -1.0f, 0.001);
    XCTAssertEqualWithAccuracy([result valueAtIndex:2], 1.0f, 0.001);
}

-(void)testRotationX {
    MSVectorND* result = [[MSTransformationManager rotationMatrixAboutXinRadians4x4:M_PI] multiplyByColumnVector:vector];
    XCTAssertEqualWithAccuracy([result valueAtIndex:0], 1.0f, 0.001);
    XCTAssertEqualWithAccuracy([result valueAtIndex:1], -1.0f, 0.001);
    XCTAssertEqualWithAccuracy([result valueAtIndex:2], -1.0f, 0.001);
}

-(void)testRotationY {
    MSVectorND* result = [[MSTransformationManager rotationMatrixAboutYinRadians4x4:M_PI] multiplyByColumnVector:vector];
    XCTAssertEqualWithAccuracy([result valueAtIndex:0], -1.0f, 0.001);
    XCTAssertEqualWithAccuracy([result valueAtIndex:1], 1.0f, 0.001);
    XCTAssertEqualWithAccuracy([result valueAtIndex:2], -1.0f, 0.001);
}

-(void)testTranslation {
    MSMatrix4D* translationMatrix = [MSTransformationManager translationMatrix4x4:1.0f y:2.0f z:3.0f];
    MSVectorND* resultingVector = [translationMatrix multiplyByColumnVector:vector];
    XCTAssertTrue([resultingVector valueAtIndex:0]   == 2.0f);
    XCTAssertTrue([resultingVector valueAtIndex:1]   == 3.0f);
    XCTAssertTrue([resultingVector valueAtIndex:2]   == 4.0f);
}

- (void)testScale {
    MSMatrix4D* scaleMatrix = [MSTransformationManager scaleMatrix4x4:2.0f repeatToIndex:2];
    [vector setValueAtIdenx:1 value:2.0f];
    [scaleMatrix setValueAtRowIndex:1 andColumnIndex:1 value:3.0f];
    MSVectorND* resultingVector = [scaleMatrix multiplyByColumnVector:vector];
    XCTAssertEqualWithAccuracy([resultingVector safeValueAtIndex:0], 2.0f, 0.001);
    XCTAssertEqualWithAccuracy([resultingVector safeValueAtIndex:1], 6.0f, 0.001);
    XCTAssertEqualWithAccuracy([resultingVector safeValueAtIndex:2], 2.0f, 0.001);
}

@end
