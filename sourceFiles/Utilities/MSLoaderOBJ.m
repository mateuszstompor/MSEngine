//
//  MSLoaderOBJ.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 25/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSLoaderOBJ.h"

@implementation MSLoaderOBJ
+(NSArray<MSModelFraction*>*)loadModel: (const char*)path{
    unsigned int currentLine=0;
    NSMutableArray<MSModelFraction*>*arrayOfModelFractions = [[NSMutableArray alloc]init];
    MSModelFraction* objectToAdd;
    FILE* modelFile=fopen(path, "r");
    if(modelFile==nil){
        [NSException raise:@"Cannot open file" format:@"file at path %s",path];
    }
    unsigned int verticiesAmountToSubstract=0;
    unsigned int normalsAmountToSubstract=0;
    bool shouldRead=true;
    while(shouldRead){
        MSOBJEventType type=[MSLoaderOBJ getTypeOfCurrentLineInFile:modelFile currentLine:currentLine];
        switch (type) {
            case COMMENT:
                [MSLoaderOBJ handleComment:modelFile model:objectToAdd];
                break;
            case OBJECT:
                if(objectToAdd!=nil){
                    [arrayOfModelFractions addObject:objectToAdd];
                    verticiesAmountToSubstract+=(unsigned int)[objectToAdd amountOfVerts];
                    normalsAmountToSubstract+=(unsigned int)[objectToAdd amountOfNormals];

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
                [MSLoaderOBJ handleFace:modelFile model:objectToAdd vToSub:verticiesAmountToSubstract nToSub:normalsAmountToSubstract];
                break;
            case FILEEND:
                shouldRead=false;
                break;
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
    MSOBJEventType returningType;
    char type;
    if((type = getc(descriptor))!=EOF){
        switch (type){
            case '#':
                returningType=COMMENT;
                break;
            case 'o':
                returningType=OBJECT;
                break;
            case 'v':
                if(getc(descriptor)==' '){
                    ungetc(' ', descriptor);
                    returningType=VERTEX;
                }
                else{
                    returningType=NORMAL;
                }
                break;
            case 's':
                returningType=S;
                break;
            case 'f':
                returningType=FACE;
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
        //printf("comment: %s", line);
    }
}
+(void)handleObject: (FILE*)descriptor model: (MSModelFraction*)model{
    char * line = NULL;
    size_t len = 0;
    fseek(descriptor,1,SEEK_CUR);
    if (getline(&line, &len, descriptor) != -1) {
        [model setName:[[NSString alloc]initWithUTF8String:line]];
    }
    //NSLog(@"name: %@", [model getName]);
    //printf("\n");
    //fflush(stdout);

}
+(void)handleVertex: (FILE*)descriptor model: (MSModelFraction*)model{
    fseek(descriptor,1,SEEK_CUR);
    float firstCo;
    float secondCo;
    float thirdCo;
    if(fscanf(descriptor,"%f %f %f",&firstCo,&secondCo,&thirdCo) == 3){
        MSPoint* point = [[MSPoint alloc]init3DimPointWithX:firstCo y:secondCo z:thirdCo];
        //[point printPoint];
        [model addVertex:point];
    }
    else{
        [NSException raise:@"Error occured!!" format:@""];
    }
    fseek(descriptor,1,SEEK_CUR);

}
+(void)handleNormal: (FILE*)descriptor model: (MSModelFraction*)model{
    fseek(descriptor,1,SEEK_CUR);
    float firstCo;
    float secondCo;
    float thirdCo;
    if(fscanf(descriptor,"%f %f %f",&firstCo,&secondCo,&thirdCo) == 3){
        MSPoint* point = [[MSPoint alloc]init3DimPointWithX:firstCo y:secondCo z:thirdCo];
        //[point printPoint];
        [model addNormal:point];
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
}
+(void)handleFace: (FILE*)descriptor model: (MSModelFraction*)arOfModels vToSub:(unsigned int)subV nToSub:(unsigned int)subN{
    fseek(descriptor,1,SEEK_CUR);
    int first[2];
    int second[2];
    int third[2];
    if(fscanf(descriptor,"%i//%i %i//%i %i//%i",first,(first+1),second,(second+1),third,(third+1)) == 6){
        MSVertexData* fData = [[MSVertexData alloc]initWithIndexOfVertex:*(first)-1-subV NormalIndex:*(first+1)-1-subN];
        MSVertexData* sData = [[MSVertexData alloc]initWithIndexOfVertex:*(second)-1-subV NormalIndex:*(second+1)-1-subN];
        MSVertexData* tData = [[MSVertexData alloc]initWithIndexOfVertex:*(third)-1-subV NormalIndex:*(third+1)-1-subN];
        MSModelFace* face =[[MSModelFace alloc] initWithData:3, fData,sData,tData];
        [arOfModels addFace:face];
    }
    else{
        [NSException raise:@"Error occured!!" format:@""];
    }
    if(feof(descriptor)==false){
        fseek(descriptor,1,SEEK_CUR);
    }
}
@end
