//
//  MSLoaderMTL.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSLoaderMTL.h"

@implementation MSLoaderMTL
+(instancetype) alloc {
    [NSException raise:@"Cannot be instantiated!"
                format:@"Static class 'MSLoaderMTL' cannot be instantiated!"];
    return nil;
}
+(MSMaterialStore*)loadMaterials: (const char*)path handler: (id<MSGraphicsResourcesHandler>) handler{
    MSMaterialStore* loadedMaterials = [[MSMaterialStore alloc] initWithGraphicsHandler:handler];
    FILE* materialFile = fopen(path, "r");
    if(materialFile==nil){
        [NSException raise:@"Cannot open file"
                    format:@"file at path %s",path];
    }
    [self processFile:materialFile materials: loadedMaterials];
    if(fclose(materialFile)!=0){
        [NSException raise:@"Cannot close file"
                    format:@"file at path %s",path];
    }
    NSLog(@"Loaded %i materials", [loadedMaterials amountOfMaterials]);
    return loadedMaterials;
}
+(void)processFile: (FILE*) file materials: (MSMaterialStore*) materials{
    unsigned int currentLine = 0;
    MSMaterial* materialUnderProcessing = nil;
    char* buffer = NULL;
    size_t length;
    size_t charactersAmount = 0;
    while((charactersAmount = getline(&buffer, &length, file)) != -1){
        MSMTLEventType typeOfEvent = [MSLoaderMTL getType:buffer length:length];
        switch(typeOfEvent){
            case NEW_MATERIAL:
                if(materialUnderProcessing!=nil){
                    [materials addMaterial:materialUnderProcessing];
                }
                materialUnderProcessing = [[MSMaterial alloc] init];
                buffer[charactersAmount-1]='\0';
                [materialUnderProcessing setName:[[NSString alloc] initWithUTF8String:&buffer[7]]];
                break;
            case MTL_COMMENT:
                break;
            case SHININESS:
            {
                float temp = 0.0f;
                if(sscanf(buffer, "Ns %f", &temp)==1){
                    [materialUnderProcessing setShininess:temp];
                }else{
                    [NSException raise:@"Cannot Read Shininess"
                                format:@""];
                }
                break;
            }
            case AMBIENT:
            {
                float temp [3];
                if(sscanf(buffer, "Ka %f %f %f", &temp[0],&temp[1],&temp[2])==3){
                    [materialUnderProcessing setAmbient:[[MSVectorND alloc] initWithArrayOfComponents:3 components:temp]];
                }else{
                    [NSException raise:@"Cannot Read Ambient"
                                format:@""];
                }
                break;
            }
            case DIFFUSE:
            {
                float temp [3];
                if(sscanf(buffer, "Kd %f %f %f", &temp[0],&temp[1],&temp[2])==3){
                    [materialUnderProcessing setDiffuse:[[MSVectorND alloc] initWithArrayOfComponents:3 components:temp]];
                }else{
                    [NSException raise:@"Cannot Read Diffuse"
                                format:@""];
                }
                break;
            }
            case SPECULAR_COLOR:
            {
                float temp [3];
                if(sscanf(buffer, "Ks %f %f %f", &temp[0],&temp[1],&temp[2])==3){
                    [materialUnderProcessing setSpecular:[[MSVectorND alloc] initWithArrayOfComponents:3 components:temp]];
                }else{
                    [NSException raise:@"Cannot Read Diffuse"
                                format:@""];
                }
                break;
            }
            case EMISSIVE:
            {
                float temp [3];
                if(sscanf(buffer, "Ke %f %f %f", &temp[0],&temp[1],&temp[2])==3){
                    [materialUnderProcessing setEmissive:[[MSVectorND alloc] initWithArrayOfComponents:3 components:temp]];
                }else{
                    [NSException raise:@"Cannot Read Emissive"
                                format:@""];
                }
                break;
            }
            case REFRACTION:
            {
                float temp = 0.0f;
                if(sscanf(buffer, "Ni %f", &temp)==1){
                    [materialUnderProcessing setRefraction:temp];
                }else{
                    [NSException raise:@"Cannot Read Refraction"
                                format:@""];
                }
                break;
            }
            case TRANSPARENCY:
            {
                float temp = 0.0f;
                if(sscanf(buffer, "d %f", &temp)==1){
                    [materialUnderProcessing setTransparency:temp];
                }else{
                    [NSException raise:@"Cannot Read Transparency"
                                format:@""];
                }
                break;
            }
            case RENDER_MODE:
            {
                int temp = 0;
                if(sscanf(buffer, "illum %i", &temp)==1){
                    [materialUnderProcessing setRenderMode:temp];
                }else{
                    [NSException raise:@"Cannot Read RenderMode"
                                format:@""];
                }
                break;
            }
            case MAP_DIFFUSE:{
                char filepath [500];
                if(sscanf(buffer, "map_Kd %s", filepath)==1){
                    NSString * nameOfTexture = [[NSString alloc] initWithUTF8String:filepath];
                    [materialUnderProcessing setAssociatedTexture: nameOfTexture];
                    if([materials getTextureWithName:nameOfTexture] == nil){
                        NSFileManager* fm = [NSFileManager defaultManager];
                        if([fm fileExistsAtPath:nameOfTexture]){
                            MSTexture* texture = [[MSTexture alloc] initTextureFromFile:nameOfTexture];
                            [materials addTexture:texture];
                        }
                    }
                }else{
                    [NSException raise:@"Cannot Read RenderMode"
                                format:@""];
                }
                break;
            }
            case SKIP:
                break;
            default:
                [NSException raise:@"Unsupported line"
                            format:@"\"%s\" line: %i", buffer, currentLine];
                break;
        }
        length=0;
        free(buffer);
        buffer=NULL;
        currentLine+=1;
    }
    [materials addMaterial:materialUnderProcessing];
}


+(MSMTLEventType) getType: (char*) line length: (size_t)length {
    switch (line[0]) {
        case '\n':
            return SKIP;
        case '#':
            return MTL_COMMENT;
        case 'n':
            return NEW_MATERIAL;
        case 'N':
            switch (line[1]) {
                case 's':
                    return SHININESS;
                case 'i':
                    return REFRACTION;
                default:
                    [NSException raise:@"Not implemented!!"
                                format:@"Symbol \"%c\"",
                     line[1]];
                    return SKIP;
            }
        case 'K':
            switch (line[1]) {
                case 'a':
                    return AMBIENT;
                case 's':
                    return SPECULAR_COLOR;
                case 'd':
                    return DIFFUSE;
                case 'e':
                    return EMISSIVE;
                default:
                    [NSException raise:@"Not implemented!!"
                                format:@"Symbol \"%c\"",
                     line[1]];
                    return SKIP;
            }
        case 'd':
            return TRANSPARENCY;
        case 'i':
            return RENDER_MODE;
        case 'm':
            if(strstr(line, "map_Kd")!=NULL){
                return MAP_DIFFUSE;
            }
        default:
            [NSException raise:@"Not implemented!!"
                        format:@"Symbol \"%c\"",
                        line[0]];
            return SKIP;
    }
}
@end
