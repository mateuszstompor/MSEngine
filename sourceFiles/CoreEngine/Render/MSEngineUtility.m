//
//  MSShaderLoader.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 23/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import "MSEngineUtility.h"

@implementation MSEngineUtility
+(GLuint)loadShaderAtFolder:(NSString*) pathToFolder fileName:(NSString*) fileName type:(GLenum) shaderType{
    NSString * fullPathToShader = [pathToFolder stringByAppendingString:fileName];
    NSMutableString * content = [[NSMutableString alloc] initWithContentsOfFile:fullPathToShader encoding:NSUTF8StringEncoding error:nil];
    
#if iOS
    NSString * iosHeader = [[NSMutableString alloc] initWithContentsOfFile:[pathToFolder stringByAppendingString:@"ios_shaders_header"] encoding:NSUTF8StringEncoding error:nil];
    [content insertString:iosHeader atIndex:0];
#elif macOS
    NSString * macHeader = [[NSMutableString alloc] initWithContentsOfFile:[pathToFolder stringByAppendingString:@"mac_shaders_header"] encoding:NSUTF8StringEncoding error:nil];
    [content insertString:macHeader atIndex:0];
#else
    [NSException raise:@"There is no shaderProgram for such device" format:@""];
#endif
    
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
+(GLuint)shaderProgramFromFiles: (NSString*) folderPath vertexShader: (NSString*) vShaderName fragmentShader: (NSString*) fShaderName{
    GLuint vertexShader = [MSEngineUtility loadShaderAtFolder:folderPath fileName:vShaderName type:GL_VERTEX_SHADER];
    GLuint fragmentShader = [MSEngineUtility loadShaderAtFolder:folderPath fileName:fShaderName type:GL_FRAGMENT_SHADER];
    return [MSEngineUtility createBasicShaderProgramWithVertexShader:vertexShader fragmentShader:fragmentShader];
}
@end
