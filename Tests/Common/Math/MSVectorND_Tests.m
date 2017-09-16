//
//  mathTests.m
//  mathTests
//
//  Created by Mateusz Stompór on 06/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSVectorND.h"

@interface mathTests : XCTestCase
{
    MSVector3D* vec1;
    MSVector3D* vec2;
    MSVector4D* vec3;
    MSVector4D* vec4;
    long testAmount;
}
@end

@implementation mathTests

- (void)setUp {
    [super setUp];
    vec1 = [[MSVectorND alloc] initWithComponents:3, 1.0f, 1.0f, 1.0f];
    vec2 = [[MSVectorND alloc] initWithComponents:3, 1.0f, 1.0f, 1.0f];
    vec3 = [[MSVectorND alloc] initWithComponents:4, 1.2f, 0.4f, 4.4f, 9.234f];
    vec4 = [[MSVectorND alloc] initWithComponents:4, 1.0f, 1.0f, 1.0f, 3.0f];
    testAmount = 300000;
}

- (void)tearDown {
    [super tearDown];
}
-(void)testIsEqualToVector {
    XCTAssertTrue([vec1 isEqualToVector:vec2]);
    [vec1 setValueAtIdenx:0 value:0.9];
    XCTAssertTrue([vec1 isEqualToVector:vec2 withMaxDifference:0.2]);
    XCTAssertFalse([vec1 isEqualToVector:vec2 withMaxDifference:0.04]);
    [vec1 setValueAtIdenx:0 value:1.0];
    XCTAssertTrue([vec1 isEqualToVector:vec4]);
    XCTAssertThrows([vec1 safeIsEqualToVector:vec3 withMaxDifference:0.1]);
    XCTAssertThrows([vec1 safeIsEqualToVector:vec3]);
}
-(void)testScalarMultiplication {
    for(int i=0; i<[vec1 getDimension]; ++i){
        [vec1 setValueAtIdenx:i value:2.0f];
    }
    for(int i=0; i<[vec1 getDimension]; ++i){
        XCTAssertTrue([vec1 valueAtIndex:i]==2.0f);
    }
    [vec1 multiplyByScalar:2.0f];
    for(int i=0; i<[vec1 getDimension]; ++i){
        XCTAssertTrue([vec1 valueAtIndex:i]==4.0f);
    }
    for(int i=0; i<[vec1 getDimension]; ++i){
        [vec1 safeSetValueAtIdenx:i value:123.0f];
    }
    [vec1 normalize];
    XCTAssertEqualWithAccuracy([vec1 length], 1.0f, 0.01);
}
-(void)testDimension {
    XCTAssertTrue([vec2 getDimension]==3);
}
-(void)testIndexBound {
    XCTAssertNoThrow([vec2 matchDimensions:vec2]);
    XCTAssertThrows([vec2 matchDimensions:vec4]);
    XCTAssertNoThrow([vec2 valueAtIndex:2]);
    XCTAssertTrue([vec3 valueAtIndex:3]==9.234f);
    XCTAssertNoThrow([vec2 valueAtIndex:4]);
    XCTAssertNoThrow([vec2 valueAtIndex:3]);
    XCTAssertThrows([vec2 safeValueAtIndex:4]);
    XCTAssertThrows([vec2 safeValueAtIndex:3]);
    XCTAssertTrue([vec3 safeValueAtIndex:3]==9.234f);

}

-(void)testVectorCrossProduct {
    //#1
    vec1 = [[MSVectorND alloc] initWithComponents:3, 0.0f, 1.0f, 0.0f];
    vec2 = [[MSVectorND alloc] initWithComponents:3, 1.0f, 0.0f, 0.0f];
    vec3 = [vec1 crossProduct:vec2];
    XCTAssertNoThrow([vec1 safeCrossProduct:vec2]);
    XCTAssertTrue([[vec1 safeCrossProduct:vec2] isEqualToVector:[vec1 crossProduct:vec2]]);
    XCTAssertTrue([vec3 valueAtIndex:0]==0);
    XCTAssertTrue([vec3 valueAtIndex:1]==0);
    XCTAssertTrue([vec3 valueAtIndex:2]==-1);
    
    //#2
    vec4 = [[MSVectorND alloc] initWithComponents:4, 0.0f, 0.0f, -1.0f, 0.0f];
    XCTAssertNoThrow([vec1 crossProduct:vec4]);
    
    //#3
    XCTAssertThrows([vec3 safeIsEqualToVector:vec4]);
    XCTAssertTrue([vec3 isEqualToVector:vec4]);

    //#4
    XCTAssertThrows([vec1 safeCrossProduct:vec4]);
    
    vec1 = [[MSVectorND alloc] initWithComponents:3, 1.0f, 2.0f, 3.0f];
    vec2 = [[MSVectorND alloc] initWithComponents:3, 1.0f, 2.0f, 3.0f];
    
    XCTAssertEqualWithAccuracy([[vec1 crossProduct:vec2] length], 0, 0.1f);
}

-(void)testVectorMultiplicationPerformance {
    [self measureBlock:^{
        for(long i=0; i<testAmount; ++i){
            [vec1 dotProduct:vec2];
        }
    }];
}
-(void)testSafeVectorMultiplicationPerformance {
    [self measureBlock:^{
        for(long i=0; i<testAmount; ++i){
            [vec1 safeDotProduct:vec2];
        }
    }];
}
-(void)testInitializers {
    int dim = 5;
    MSVectorND* someVector = [MSVectorND onesVector:dim];
    XCTAssertTrue([someVector getDimension]==dim);
    for (int i=0; i<[someVector getDimension]; ++i){
        XCTAssertTrue([someVector valueAtIndex:i]==1.0f);
    }
    dim = 4;
    someVector = [[MSVectorND alloc] initZeroVecWithDimension:dim];
    XCTAssertTrue([someVector getDimension]==dim);
    for (int i=0; i<[someVector getDimension]; ++i){
        XCTAssertTrue([someVector valueAtIndex:i]==0.0f);
    }
    MSVectorND* someSecondVector = [[MSVectorND alloc] initWithVector:someVector];
    XCTAssertTrue([someVector isEqualToVector:someSecondVector]);
    XCTAssertTrue([someVector getArrayStyleVector] != [someSecondVector getArrayStyleVector]);
    XCTAssertTrue([someVector getDimension] == [someSecondVector getDimension]);
}
-(void)testLength {
    [vec1 normalize];
    XCTAssertEqualWithAccuracy([vec1 length], 1.0f, 0.1f);
    XCTAssertEqualWithAccuracy([vec1 lengthSquared], 1.0f, 0.01f);

}
-(void)testMultiplyByMatrix {
    //#1
    XCTAssertNoThrow([vec1 safeMultiplyByMatrix:[MSMatrixND identityMatrix:3]]);
    XCTAssertThrows([vec1 safeMultiplyByMatrix:[MSMatrixND identityMatrix:4]]);
    
    //#2
    XCTAssertTrue([[vec1 safeMultiplyByMatrix:[MSMatrixND identityMatrix:3]] isEqualToVector:[vec1 multiplyByMatrix:[MSMatrixND identityMatrix:4]]]);
    
    //#3
    XCTAssertTrue([[vec1 safeMultiplyByMatrix:[MSMatrixND identityMatrix:3]] isEqualToVector:[vec1 multiplyByMatrix:[MSMatrixND identityMatrix:3]]]);

    vec1 = [[MSVectorND alloc] initZeroVecWithDimension:3];
    XCTAssertTrue([[vec1 multiplyByMatrix:[MSMatrixND identityMatrix:3]] isEqualToVector:[[MSVectorND alloc] initZeroVecWithDimension:3]]);
    
}
-(void)testAdd {
    [vec1 normalize];
    XCTAssertNoThrow([vec1 add:vec4]);
    [vec1 normalize];
    XCTAssertEqualWithAccuracy([vec1 lengthSquared], 1.0f, 0.01f);
    vec1 = [MSVectorND onesVector:3];
    vec2 = [MSVectorND onesVector:3];
    MSVectorND* someVec3 = [vec1 newVectorFromAddition:vec2];
    for(int i=0; i<[someVec3 getDimension]; ++i){
        XCTAssertTrue([someVec3 valueAtIndex:i] == [vec1 valueAtIndex:i] + [vec2 valueAtIndex:i]);
    }
    XCTAssertTrue([someVec3 getArrayStyleVector] != [vec2 getArrayStyleVector]);
    XCTAssertTrue([someVec3 getArrayStyleVector] != [vec1 getArrayStyleVector]);
    someVec3 = [vec1 newVectorFromSafeAddition:vec2];
    for(int i=0; i<[someVec3 getDimension]; ++i){
        XCTAssertTrue([someVec3 valueAtIndex:i] == [vec1 valueAtIndex:i] + [vec2 valueAtIndex:i]);
    }
    XCTAssertTrue([someVec3 getArrayStyleVector] != [vec2 getArrayStyleVector]);
    XCTAssertTrue([someVec3 getArrayStyleVector] != [vec1 getArrayStyleVector]);
    XCTAssertThrows([vec1 newVectorFromSafeAddition:vec4]);
}
-(void)testSubtract {
    vec1 = [MSVectorND onesVector:4];
    vec2 = [[MSVectorND alloc] initWithZerosExceptIndex:0 number:0.0f dimensionOfVector:4];
    MSVectorND* someVec = [vec1 newVectorFromSubtraction:vec2];
    for(int i=0; i<[someVec getDimension]; ++i){
        XCTAssertTrue([someVec valueAtIndex:i] == [vec1 valueAtIndex:i]);
    }
    someVec = [vec2 newVectorFromSubtraction:vec1];
    XCTAssertTrue([someVec getArrayStyleVector] != [vec2 getArrayStyleVector]);
    XCTAssertTrue([someVec getArrayStyleVector] != [vec1 getArrayStyleVector]);
    for(int i=0; i<[someVec getDimension]; ++i){
        XCTAssertTrue([someVec valueAtIndex:i] == -[vec1 valueAtIndex:i]);
    }
    vec1 = [MSVectorND onesVector:2];
    XCTAssertThrows([vec1 safeAdd:vec2]);
    XCTAssertTrue([[[vec1 newVectorFromSafeAddition:vec1] newVectorFromSubtraction:vec1] isEqualToVector:vec1]);
}
-(void)testInitializerInitWithComponents {
    [self measureBlock:^{
        for(long i=0; i<testAmount; ++i){
            vec1 = [[MSVectorND alloc] initWithComponents:3, 1.0f, 1.0f, 1.0f];
        }
    }];
}
-(void)testInitializerInitWithOnes {
    [self measureBlock:^{
        for(long i=0; i<testAmount; ++i){
            vec1 = [MSVectorND onesVector:3];
        }
    }];
}
-(void)testInitializerInitWithDimmension {
    [self measureBlock:^{
        for(long i=0; i<testAmount; ++i){
            vec1 = [[MSVectorND alloc] initVecWithDimension:3];
        }
    }];
}
-(void)testInitializerInitWithArrayOfComponents {
    [self measureBlock:^{
        for(long i=0; i<testAmount; ++i){
            vec1 = [[MSVectorND alloc] initWithArrayOfComponents:3 components:[vec2 getArrayStyleVector]];
        }
    }];
}
-(void)testInitializerInitWithVector {
    [self measureBlock:^{
        for(long i=0; i<testAmount; ++i){
            vec1 = [[MSVectorND alloc] initWithVector:vec2];
        }
    }];
}
-(void)testInitalizerInitWithZero {
    [self measureBlock:^{
        for(long i=0; i<testAmount; ++i){
            vec1 = [[MSVectorND alloc] initZeroVecWithDimension:3];
        }
    }];
}
-(void)testInitalizerInitWithZeroExcept {
    [self measureBlock:^{
        for(long i=0; i<testAmount; ++i){
            vec1 = [[MSVectorND alloc] initWithZerosExceptIndex:2 number:3.0f dimensionOfVector:3];
        }
    }];
}
@end
