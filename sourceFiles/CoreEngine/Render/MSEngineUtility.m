//
//  MSShaderLoader.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import "MSEngineUtility.h"

@implementation MSEngineUtility
+(GLuint)loadShader:(const char*)path type:(GLenum) type maxAmountOfCharacters:(unsigned long) maxAmount{
    GLchar* buffer=(char*)malloc(maxAmount*sizeof(GLchar));
    FILE* file = fopen(path, "r");
    if(file==NULL){
        perror("cannot open file from path");
        [NSException raise:@"Cannot open file" format:@"file at path %s",path];
    }
    unsigned long long i=0;
    char c;
    while((c=getc(file))!=EOF){
        *(buffer+i)=c;
        i+=1;
    }
    *(buffer+i)='\0';
    if(fclose(file)!=0){
        [NSException raise:@"Cannot close file" format:@"file at path %s",path];
    }
    GLuint shader=glCreateShader(type);
    glShaderSource(shader, 1,(GLchar const * const *)&buffer, NULL);
    glCompileShader(shader);
    GLint status;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &status);
    if(status!=GL_TRUE){
        char errorbuffer[512];
        glGetShaderInfoLog(shader, 512, NULL, errorbuffer);
        printf("%s",errorbuffer);
        [NSException raise:@"Program stopped due to shader compilation failure" format:@""];
    }
    free (buffer);
    return shader;
}
+(GLuint)createBasicShaderProgramWithVertexShader: (GLuint)vertexSh fragmentShader: (GLuint)fragmentSh{
    GLuint shaderProgram = glCreateProgram();
    glAttachShader(shaderProgram, vertexSh);
    glAttachShader(shaderProgram, fragmentSh);
    glLinkProgram(shaderProgram);
    glUseProgram(shaderProgram);
    glDeleteShader(vertexSh);
    glDeleteShader(fragmentSh);
    [MSEngineUtility lookForErrors];
    return shaderProgram;
}
+(void)lookForErrors{
    if(glGetError()!=0){
        printf("error occured");
        [NSException raise:@"OpenGL failure" format:@""];
    }
}
+(GLuint)generateShaderProgramFromVertexShader: (const char*)vShader fragmentShader:(const char*)fShader{
    GLuint vertexShader = [MSEngineUtility loadShader:vShader type:GL_VERTEX_SHADER maxAmountOfCharacters:3000];
    GLuint fragmentShader = [MSEngineUtility loadShader:fShader type:GL_FRAGMENT_SHADER maxAmountOfCharacters:3000];
    return [MSEngineUtility createBasicShaderProgramWithVertexShader:vertexShader fragmentShader:fragmentShader];
}
@end
