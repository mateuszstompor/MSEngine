//
//  MSMatrixND_Tests.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 14/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSMatrixND.h"
#import "MSVectorND.h"

@interface MSMatrixND_Tests : XCTestCase
{
    MSMatrix2D* firstMatrix2D;
    MSMatrix2D* secondMatrix2D;

    MSMatrix3D* firstMatrix3D;
    MSMatrix4D* firstMatrix4D;
    MSMatrix4D* secondMatrix4D;
    
    MSVector4D* firstVector4D;
    MSVector3D* firstVector3D;
    long amountOfTests;
}
@end

@implementation MSMatrixND_Tests

- (void)setUp {
    [super setUp];
    firstMatrix4D = [[MSMatrixND alloc] initWithIdentityMatrix:4];
    firstMatrix2D = [[MSMatrixND alloc] initWithIdentityMatrix:2];
    secondMatrix2D = [[MSMatrixND alloc] initWithMatrix:firstMatrix2D];
    firstVector4D = [[MSVectorND alloc] initWithComponents:4, 1.0f, 1.0f, 1.0f, 1.0f];
    firstVector3D = [[MSVectorND alloc] initWithComponents:3, 1.0f, 1.0f, 1.0f];
    amountOfTests = 300000;
}

- (void)tearDown {
    [super tearDown];
}

-(void)testisEqualToMatrix {
    //#1
    firstMatrix4D = [[MSMatrixND alloc] initWithIdentityMatrix:4];
    secondMatrix4D = [[MSMatrixND alloc] initWithIdentityMatrix:4];
    XCTAssertTrue([firstMatrix4D isEqualToMatrix:secondMatrix4D]);
    
    //#2
    XCTAssertTrue([firstMatrix4D isEqualToMatrix:secondMatrix4D withPrecision:2.0f]);
    
    //#3
    [firstMatrix4D setValueAtRowIndex:0 andColumnIndex:0 value:1.1f];
    XCTAssertTrue([firstMatrix4D isEqualToMatrix:secondMatrix4D withPrecision:0.11]);
    XCTAssertFalse([firstMatrix4D isEqualToMatrix:secondMatrix4D withPrecision:0.08]);
}

-(void)testMatrixMultiplicationAndMultiplyByScalar {
    //#1
    firstMatrix4D = [MSMatrixND identityMatrix:4];
    secondMatrix4D = [MSMatrixND identityMatrix:4];
    MSMatrixND* resultMatrix = [firstMatrix4D multiplyByMatrix:secondMatrix4D];
    XCTAssertTrue([firstMatrix4D isEqualToMatrix:resultMatrix withPrecision:0.01f]);
    
    //#2
    [firstMatrix4D multiplyByScalar:2.0f];
    firstMatrix4D = [firstMatrix4D multiplyByMatrix:[MSMatrixND identityMatrix:4]];
    MSVector4D* vector4D = [[MSVectorND alloc] initWithComponents:4, 1.0f, 1.0f, 1.0f, 1.0f];
    vector4D = [firstMatrix4D multiplyByColumnVector:vector4D];
    MSVectorND* anotherVector4D = [[MSVectorND alloc] initWithComponents:4, 1.0f, 1.0f, 1.0f, 1.0f];
    [anotherVector4D multiplyByScalar:2.0f];
    XCTAssertTrue([anotherVector4D safeIsEqualToVector:vector4D withMaxDifference:0.01f]);
}
-(void)testSafeMatrixMultiplication {
    //#1
    MSMatrixND* result = [firstMatrix4D safeMultiplyByMatrix:secondMatrix4D];
    XCTAssertNoThrow([firstMatrix4D safeMultiplyByMatrix:secondMatrix4D]);
    [result isEqualToMatrix:[MSMatrixND identityMatrix:4]];
    
    //#2
    XCTAssertThrows([firstMatrix3D safeMultiplyByMatrix:secondMatrix4D]);
    //#3
    XCTAssertThrows([firstMatrix4D multiplyByColumnVector:firstVector3D]);
    //#4
    XCTAssertNoThrow([firstMatrix4D multiplyByColumnVector:firstVector3D]);
}

-(void)testMultiplyByVector {
    //#1
    MSVectorND* someVector4D = [[MSVectorND alloc] initWithComponents:4, 2.0f, 1.3f, 1.9f, 102.3f];
    
    XCTAssertNoThrow([firstMatrix4D multiplyByColumnVector:someVector4D]);
    MSVectorND* result = [firstMatrix4D multiplyByColumnVector:someVector4D];
    XCTAssertTrue([result safeIsEqualToVector: someVector4D]);
    
    //#2
    MSVectorND* someVector3D = [[MSVectorND alloc] initWithComponents:3, 2.0f, 1.3f, 1.9f];
    XCTAssertThrows([firstMatrix4D safeMultiplyByColumnVector:someVector3D]);
    
    //#3
    someVector4D = [[MSVectorND alloc] initWithComponents:4, 2.2f, 1.3f, 1.93f, 1302.3f];
    
    XCTAssertNoThrow([firstMatrix4D safeMultiplyByColumnVector:someVector4D]);
    result = [firstMatrix4D safeMultiplyByColumnVector:someVector4D];
    XCTAssertTrue([result safeIsEqualToVector: someVector4D]);
    
}
- (void)testPerformanceInitializeFromAnotherMatrix {
    [self measureBlock:^{
        for(int i=0; i<amountOfTests; ++i){
            secondMatrix2D = [[MSMatrixND alloc]initWithMatrix:firstMatrix2D];
        }
    }];
}

- (void)testPerformanceGetColumnMajor1DMatrix {
    [self measureBlock:^{
        for(int i=0; i<amountOfTests; ++i){
            [firstMatrix4D matrixAsArray];
        }
    }];
}


@end
