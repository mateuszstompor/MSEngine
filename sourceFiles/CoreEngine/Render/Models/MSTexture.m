//
//  MSTexture.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 11/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSTexture.h"

#define COMPONENTS_PER_FRAGMENT 3

@implementation MSTexture

@synthesize name = _name;

-(instancetype)init{
    self = [super init];
    if (self){
        self->data = nil;
        self->width = 0;
        self->height = 0;
        self->_name = nil;
    }
    return self;
}

-(instancetype)initTextureFromFile: (NSString*) path{
    self=[self init];
    if (self){
        self->_name = path;
        [self loadDataFrom: path];
    }
    return self;
}

-(void)dealloc{
    free(self->data);
}

-(void)loadDataFrom: (NSString*) filepath {
    unsigned char header[54];
    unsigned int dataPos;
    unsigned int imageSize;
    FILE * file = fopen([filepath UTF8String],"rb");
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
    width      = *(int*)&(header[0x12]);
    height     = *(int*)&(header[0x16]);
    if (imageSize==0){
        imageSize=width*height*COMPONENTS_PER_FRAGMENT;
    }
    if (dataPos==0){
        dataPos=54;
    }
    self->data = (unsigned char*)malloc(imageSize*sizeof(unsigned char));
    fread(data,1,imageSize,file);
    fclose(file);
}

@end

