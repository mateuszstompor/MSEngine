//
//  MSLoaderOBJ.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSLoaderOBJ.h"

@implementation MSLoaderOBJ

static int first[3];
static int second[3];
static int third[3];
static float coord[3];

+(instancetype)alloc{
    [NSException raise:@"Cannot be instantiated!" format:@"Static class 'MSLoaderOBJ' cannot be instantiated!"];
    return nil;
}
+(NSArray<MSModelFraction*>*)loadModel: (const char*)path tieWithMaterials: (MSMaterialStore*) store{
    unsigned int currentLine=0;
    NSMutableArray<MSModelFraction*>*arrayOfModelFractions = [[NSMutableArray alloc]init];
    MSModelFraction* objectToAdd;
    FILE* modelFile=fopen(path, "r");
    if(modelFile==nil){
        [NSException raise:@"Cannot open file" format:@"file at path %s",path];
    }
    unsigned int verticiesAmountToSubtract=0;
    unsigned int normalsAmountToSubtract=0;
    unsigned int textureAmountToSubtract=0;
   
    bool shouldRead=true;
    while(shouldRead){
        MSOBJEventType type=[MSLoaderOBJ getTypeOfCurrentLineInFile:modelFile currentLine:currentLine];
        switch (type) {
            case OBJ_COMMENT:
                [MSLoaderOBJ handleComment:modelFile model:objectToAdd];
                break;
            case OBJECT:
                if(objectToAdd!=nil){
                    [arrayOfModelFractions addObject:objectToAdd];
                    verticiesAmountToSubtract+=(unsigned int)[[objectToAdd vertices] count];
                    normalsAmountToSubtract+=(unsigned int)[[objectToAdd normals] count];
                    textureAmountToSubtract+=(unsigned int)[[objectToAdd textureCoordinates] count];

                }
                objectToAdd=[[MSModelFraction alloc]init];
                [MSLoaderOBJ handleObject:modelFile model:objectToAdd];
                break;
            case VERTEX:
                [MSLoaderOBJ handleVertex:modelFile model:objectToAdd ];
                break;
            case NORMAL:
                [MSLoaderOBJ handleNormal:modelFile model:objectToAdd];
                break;
            case S:
                [MSLoaderOBJ handleS:modelFile model:objectToAdd];
                break;
            case FACE:
                [MSLoaderOBJ handleFace:modelFile model:objectToAdd vToSub:verticiesAmountToSubtract nToSub:normalsAmountToSubtract tToSub: textureAmountToSubtract];
                break;
            case TEXTURE:
                [MSLoaderOBJ handleTexture:modelFile model:objectToAdd];
                break;
            case USEMATERIAL:
                [MSLoaderOBJ handleMaterial:modelFile model:objectToAdd tieWithMaterials:store];
                break;
            case FILEEND:
                shouldRead=false;
                break;
            case MATERIAL_LIB:
            {
                char* temp_ptr=NULL;
                size_t temp_length = 0;
                getline(&temp_ptr, &temp_length, modelFile);
                free(temp_ptr);
            }
            default:
                break;
        }
        currentLine+=1;
    }
    if(fclose(modelFile)!=0){
        [NSException raise:@"Cannot close file" format:@"file at path %s",path];
    }
    [arrayOfModelFractions addObject:objectToAdd];
    return arrayOfModelFractions;
}
+(MSOBJEventType)getTypeOfCurrentLineInFile: (FILE*)descriptor currentLine:(long long)currentLine{
    MSOBJEventType returningType = ERROR;
    char type;
    if((type = getc(descriptor))!=EOF){
        switch (type){
            case '#':
                returningType=OBJ_COMMENT;
                break;
            case 'o':
                returningType=OBJECT;
                break;
            case 'v':{
                char nextCharacter = getc(descriptor);
                if(nextCharacter == ' '){
                    ungetc(' ', descriptor);
                    returningType=VERTEX;
                }
                if(nextCharacter == 'n'){
                    returningType=NORMAL;
                }
                if(nextCharacter == 't'){
                    returningType=TEXTURE;
                }
                break;
            }
            case 's':
                returningType=S;
                break;
            case 'f':
                returningType=FACE;
                break;
            case 'm':
                returningType=MATERIAL_LIB;
                break;
            case 'u':
                returningType=USEMATERIAL;
                break;
            default:
                [NSException raise:@"Not implemented!!"
                            format:@"Symbol \"%c\" in line %llul",
                            type, (unsigned long long)currentLine];
                break;
        }
    }
    else{
        returningType=FILEEND;
    }
    return returningType;
}
+(void)handleComment: (FILE*)descriptor model: (MSModelFraction*)model{
    char * line = NULL;
    size_t len = 0;
    fseek(descriptor,1,SEEK_CUR);
    if (getline(&line, &len, descriptor) != -1) {
        free(line);
    }
}
+(void)handleObject: (FILE*)descriptor model: (MSModelFraction*)model{
    char * line = NULL;
    size_t len = 0;
    fseek(descriptor,1,SEEK_CUR);
    if (getline(&line, &len, descriptor) != -1) {
        [model setName:[[NSString alloc]initWithUTF8String:line]];
        free(line);
    }
}
+(void)handleMaterial: (FILE*)descriptor model: (MSModelFraction*)model tieWithMaterials: (MSMaterialStore*) store{
    char * line = NULL;
    size_t len = 0;
    size_t characterAmount = 0;
    if ((characterAmount = getline(&line, &len, descriptor)) != -1){
        line[characterAmount-1]='\0';
        NSString* nameOfMaterial = [[NSString alloc] initWithUTF8String:&line[6]];
            [model setMaterial:[store getMaterialWithName:nameOfMaterial]];
    }
    free(line);
}
+(void)handleVertex: (FILE*)descriptor model: (MSModelFraction*)model{
    fseek(descriptor,1,SEEK_CUR);
    if(fscanf(descriptor,"%f %f %f",&coord[0],&coord[1],&coord[2]) == 3){
        MSPoint* point = [[MSPoint alloc]init3DimPointWithX:coord[0] y:coord[1] z:coord[2]];
        [[model vertices] addObject:point];
    }
    else{
        [NSException raise:@"Error occured!!" format:@""];
    }
    fseek(descriptor,1,SEEK_CUR);

}
+(void)handleTexture: (FILE*)descriptor model: (MSModelFraction*)model{
    fseek(descriptor,1,SEEK_CUR);
    if(fscanf(descriptor,"%f %f",&coord[0],&coord[1]) == 2){
        MSPoint* point = [[MSPoint alloc]init2DimPointWithX: coord[0] y:coord[1]];
        [[model textureCoordinates] addObject:point];
    }
    else{
        [NSException raise:@"Error occured!!" format:@""];
    }
    fseek(descriptor,1,SEEK_CUR);
    
}
+(void)handleNormal: (FILE*)descriptor model: (MSModelFraction*)model{
    fseek(descriptor,1,SEEK_CUR);
    if(fscanf(descriptor,"%f %f %f",&coord[0],&coord[1],&coord[2]) == 3){
        MSPoint* point = [[MSPoint alloc]init3DimPointWithX:coord[0] y:coord[1] z:coord[2]];
        [[model normals] addObject:point];
    }
    else{
        [NSException raise:@"Error occured!!" format:@""];
    }
    if(feof(descriptor)==false){
        fseek(descriptor,1,SEEK_CUR);
    }
}
+(void)handleS: (FILE*)descriptor model: (MSModelFraction*)model{
    fseek(descriptor,1,SEEK_CUR);
    char * line = NULL;
    size_t len = 0;
    if (getline(&line, &len, descriptor) != -1) {
        //printf("s: %s", line);
    }
    free(line);
}
+(void)handleFace: (FILE*)descriptor model: (MSModelFraction*)arOfModels vToSub:(unsigned int)subV nToSub:(unsigned int)subN tToSub: (unsigned int)subT{
    fseek(descriptor,1,SEEK_CUR);
    char *currentLine = NULL;
    size_t len = 0;
    if(getline(&currentLine, &len, descriptor)==-1){
        [NSException raise:@"Error occured!!" format:@""];
    }    
    if(sscanf(currentLine,"%i/%i/%i %i/%i/%i %i/%i/%i",first,(first+2),(first+1),second,(second+2),(second+1),third,(third+2),(third+1)) == 9){
    }
    else{
        if(sscanf(currentLine,"%i//%i %i//%i %i//%i",first,(first+1),second,(second+1),third,(third+1)) == 6){
            *(first+2)=0;
            *(second+2)=0;
            *(third+2)=0;
        }
        else{
            [NSException raise:@"Error occured!!" format:@""];
        }
    }
    free(currentLine);
    MSVertexData* fData = [[MSVertexData alloc]initWithIndexOfVertex:*(first)-1-subV normalIndex:*(first+1)-1-subN textureIndex:*(first+2)-1-subT];
    MSVertexData* sData = [[MSVertexData alloc]initWithIndexOfVertex:*(second)-1-subV normalIndex:*(second+1)-1-subN textureIndex:*(second+2)-1-subT];
    MSVertexData* tData = [[MSVertexData alloc]initWithIndexOfVertex:*(third)-1-subV normalIndex:*(third+1)-1-subN textureIndex:*(third+2)-1-subT];
    MSModelFace* face =[[MSModelFace alloc] initWithData:3, fData,sData,tData];
    [[arOfModels facesData] addObject:face];
    
}

@end
