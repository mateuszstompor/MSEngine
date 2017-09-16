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
    MSMatrix4D* identityBaseVectorMatrix4D;
}
@end

@implementation MSTransformationManager_Tests

- (void)setUp {
    [super setUp];
    identityBaseVectorMatrix4D = [MSMatrixND identityMatrix:4];
}

-(void)testDegressToRadians {
    XCTAssertEqualWithAccuracy([MSTransformationManager radians:360], 2*M_PI, 0.01);
    XCTAssertEqualWithAccuracy([MSTransformationManager radians:0], 0, 0.001);
    XCTAssertEqualWithAccuracy([MSTransformationManager radians:180], M_PI, 0.001);
}

- (void)tearDown {
    [super tearDown];
}

-(void)testTranslation {
    MSMatrix4D* translationMatrix = [MSTransformationManager translationMatrix4x4:1.0f y:2.0f z:3.0f];
    MSVectorND* vector = [MSVectorND onesVector:4];
    MSVectorND* resultingVector = [translationMatrix multiplyByColumnVector:vector];
    XCTAssertTrue([resultingVector valueAtIndex:0]   == 2.0f);
    XCTAssertTrue([resultingVector valueAtIndex:1]   == 3.0f);
    XCTAssertTrue([resultingVector valueAtIndex:2]   == 4.0f);
}

- (void)testScale {
    MSMatrix4D* scaleMatrix = [MSTransformationManager scaleMatrix4x4:2.0f repeatToIndex:2];
    [identityBaseVectorMatrix4D setValueAtRowIndex:1 andColumnIndex:1 value:3.0f];
    MSMatrixND* result = [scaleMatrix multiplyByMatrix: identityBaseVectorMatrix4D];
    MSVector4D* onesVec = [MSVectorND onesVector:4];
    MSVectorND* resultingVector = [result multiplyByColumnVector:onesVec];
    XCTAssertTrue([resultingVector safeValueAtIndex:0] == 2.0f);
    for (int i=0; i<4; ++i) {
        NSLog(@"%i. value: %f", i, *([resultingVector getArrayStyleVector]+i));
    }
    XCTAssertTrue([resultingVector safeValueAtIndex:1] == 6.0f);
    XCTAssertTrue([resultingVector safeValueAtIndex:0] == 2.0f);
}

@end
