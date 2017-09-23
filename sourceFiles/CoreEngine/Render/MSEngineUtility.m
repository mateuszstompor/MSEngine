//
//  MSShaderLoader.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import "MSEngineUtility.h"

@implementation MSEngineUtility
+(GLuint)loadShaderAtPath:(NSString*) filePath type:(GLenum) shaderType{
    NSMutableString * content = [[NSMutableString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];

    NSBundle* bundle = [NSBundle bundleForClass:[MSEngineUtility class]];
    NSString* pathToConstants = [bundle pathForResource:@"MSGraphicsConstants" ofType:@"h"];
    NSString * constantDefinitions = [[NSString alloc] initWithContentsOfFile:pathToConstants];
    if (constantDefinitions == nil) {
        [NSException raise:@"Cannot find constants header" format:@""];
    }
    [content insertString:constantDefinitions atIndex:0];
#if iOS
    NSString* pathToHeader = [bundle pathForResource:@"ios_shaders_header" ofType:@""];
    NSString * iosHeader = [[NSString alloc] initWithContentsOfFile:pathToHeader];
    if (iosHeader == nil) {
        [NSException raise:@"Cannot find ios header" format:@""];
    }
    [content insertString:iosHeader atIndex:0];
#elif macOS
    NSString* pathToHeader = [bundle pathForResource:@"mac_shaders_header" ofType:@""];
    NSString * macHeader = [[NSString alloc] initWithContentsOfFile:pathToHeader];
    if (macHeader == nil) {
        [NSException raise:@"Cannot find mac header" format:@""];
    }
    [content insertString:macHeader atIndex:0];
#else
    [NSException raise:@"There is no shaderProgram for such device" format:@""];
#endif
    return [self compileShaderProgram:content withType:shaderType];
}

+(GLuint)compileShaderProgram: (NSString*) content withType:(GLenum) shaderType {
    const char * buffer = [content UTF8String];
    GLuint shader=glCreateShader(shaderType);
    glShaderSource(shader, 1,(GLchar const * const *)&buffer, NULL);
    glCompileShader(shader);
    GLint status;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &status);
    if(status!=GL_TRUE){
        GLint length = 0;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &length);
        char* errorbuffer = (char*)malloc(length*sizeof(char));
        glGetShaderInfoLog(shader, length, NULL, errorbuffer);
        printf("%s",errorbuffer);
        free(errorbuffer);
        [NSException raise:@"Program stopped due to shader compilation failure" format:@""];
    }
    return shader;
}

+(GLuint)createBasicShaderProgramWithVertexShader: (GLuint) vertexShader fragmentShader: (GLuint) fragmentShader{
    GLuint shaderProgram = glCreateProgram();
    glAttachShader(shaderProgram, vertexShader);
    glAttachShader(shaderProgram, fragmentShader);
    glLinkProgram(shaderProgram);
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
    return shaderProgram;
}

+(GLuint)shaderProgramFromVertexShaderPath: (NSString*) vShaderPath fragmentShaderPath: (NSString*) fShaderPath{
    GLuint vertexShader = [MSEngineUtility loadShaderAtPath: vShaderPath type:GL_VERTEX_SHADER];
    GLuint fragmentShader = [MSEngineUtility loadShaderAtPath: fShaderPath type:GL_FRAGMENT_SHADER];
    return [MSEngineUtility createBasicShaderProgramWithVertexShader:vertexShader fragmentShader:fragmentShader];
}
@end
