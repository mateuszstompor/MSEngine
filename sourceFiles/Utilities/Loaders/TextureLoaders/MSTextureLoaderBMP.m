//
//  MSTextureLoaderBMP.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSTextureLoaderBMP.h"

#define COMPONENTS_PER_FRAGMENT 3

@implementation MSTextureLoaderBMP
+(MSTexture*)loadTextureAtPath: (NSString*)pathToTexture itsName: (NSString*) nam{
    unsigned char header[54];
    unsigned int dataPos;
    unsigned int imageSize;
    FILE * file = fopen([pathToTexture UTF8String],"rb");
    if (!file){
        [NSException raise:@"Cannot open file" format:@""];
    }
    if ( fread(header, 1, 54, file)!=54 ){ // If not 54 bytes read : problem
        [NSException raise:@"Incorrect BMP file" format:@""];
    }
    if ( header[0]!='B' || header[1]!='M' ){
        [NSException raise:@"Incorrect BMP file header" format:@""];
    }
    dataPos    = *(int*)&(header[0x0A]);
    imageSize  = *(int*)&(header[0x22]);
    unsigned int widthOfTexture = *(int*)&(header[0x12]);
    unsigned int heightOfTexture = *(int*)&(header[0x16]);
    if (imageSize==0){
        imageSize=widthOfTexture*heightOfTexture*COMPONENTS_PER_FRAGMENT;
    }
    if (dataPos==0){
        dataPos=54;
    }
    unsigned char * dat = (unsigned char*)malloc(imageSize*sizeof(unsigned char));
    fread(dat,1,imageSize,file);
    fclose(file);
    MSTexture* texture = [[MSTexture alloc] initWithData:dat width:widthOfTexture height:heightOfTexture];
    [texture setName:nam];
    return texture;
}
@end
