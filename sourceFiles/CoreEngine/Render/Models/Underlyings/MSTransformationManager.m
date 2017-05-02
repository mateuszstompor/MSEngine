//
//  MSTransformationManager.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSTransformationManager.h"

@implementation MSTransformationManager
+(MSMatrixND*)rotationMatrixAboutXinRadians4x4: (float) radians{
    MSMatrixND* matrixToReturn = [MSMatrixND identityMatrix:4];
    [matrixToReturn setValueAtRowIndex:1 andColumnIndex:1 value:cosf(radians)];
     [matrixToReturn setValueAtRowIndex:1 andColumnIndex:2 value:-sinf(radians)];
     [matrixToReturn setValueAtRowIndex:2 andColumnIndex:2 value:cosf(radians)];
     [matrixToReturn setValueAtRowIndex:2 andColumnIndex:1 value:sinf(radians)];
    return matrixToReturn;
}
+(MSMatrixND*)rotationMatrixAboutYinRadians4x4: (float) radians{
    MSMatrixND* matrixToReturn = [MSMatrixND identityMatrix:4];
    [matrixToReturn setValueAtRowIndex:0 andColumnIndex:0 value:cosf(radians)];
    [matrixToReturn setValueAtRowIndex:0 andColumnIndex:2 value:-sinf(radians)];
    [matrixToReturn setValueAtRowIndex:2 andColumnIndex:2 value:cosf(radians)];
    [matrixToReturn setValueAtRowIndex:2 andColumnIndex:0 value:sinf(radians)];
    return matrixToReturn;
}
+(MSMatrixND*)rotationMatrixAboutZinRadians4x4: (float) radians{
    MSMatrixND* matrixToReturn = [MSMatrixND identityMatrix:4];
    [matrixToReturn setValueAtRowIndex:0 andColumnIndex:0 value:cosf(radians)];
    [matrixToReturn setValueAtRowIndex:0 andColumnIndex:1 value:sinf(radians)];
    [matrixToReturn setValueAtRowIndex:1 andColumnIndex:1 value:cosf(radians)];
    [matrixToReturn setValueAtRowIndex:1 andColumnIndex:0 value:-sinf(radians)];
    return matrixToReturn;
}
+(MSMatrixND*)scaleMatrix4x4: (float)factor repeatToIndex: (int) repeat{
    MSMatrixND* matrixToReturn = [MSMatrixND identityMatrix:4];
    for(int i=0; i<3;i++){
        [matrixToReturn setValueAtRowIndex:i andColumnIndex:i value:factor];
    }
    return matrixToReturn;
}
+(MSMatrixND*)translationMatrix4x4: (float)x y:(float)y z:(float)z{
    MSMatrixND* matrixToReturn = [MSMatrixND identityMatrix:4];
    [matrixToReturn setValueAtRowIndex:0 andColumnIndex:3 value:x];
    [matrixToReturn setValueAtRowIndex:1 andColumnIndex:3 value:y];
    [matrixToReturn setValueAtRowIndex:2 andColumnIndex:3 value:z];
    return matrixToReturn;
}
+(float)radians: (float)degress{
    return degress*(180.0f/M_PI);
}
+(MSMatrixND*)perpsectiveWithFoV: (float)fov aspectRatio: (float)ar near:(float)near far:(float)far{
    MSMatrixND* result;
    
    float q = 1.0f / tan([self radians:0.5*fov]);
    float A = q / ar;
    float B = (near + far) / (near - far);
    float C = (2.0f * near * far) / (near - far);
    
    
    MSVectorND* firstColumn = [[MSVectorND alloc] initWithComponents:4, A,0.0f,0.0f,0.0f];
    MSVectorND* secondColumn = [[MSVectorND alloc] initWithComponents:4, 0.0f,q,0.0f,0.0f];
    MSVectorND* thirdColumn = [[MSVectorND alloc] initWithComponents:4, 0.0f,0.0f,B,-1.0f];
    MSVectorND* fourthColumn = [[MSVectorND alloc] initWithComponents:4, 0.0f,0.0f,C,0.0f];
    result=  [[MSMatrixND alloc] initWithVectors:4,firstColumn,secondColumn,thirdColumn,fourthColumn];
    return result;
}
@end
