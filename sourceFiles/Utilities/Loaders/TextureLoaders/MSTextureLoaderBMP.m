//
//  MSTextureLoaderBMP.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSTextureLoaderBMP.h"

@implementation MSTextureLoaderBMP

+(MSTexture*)loadTextureAtPath: (NSString*)pathToTexture itsName: (NSString*) nam{
    
    CGImageRef spriteImage;
    
#if macOS
    NSImage* textureImage = [[NSImage alloc] initWithContentsOfFile: pathToTexture];
    NSRect rect = NSMakeRect(0, 0, textureImage.size.width, textureImage.size.height);
    spriteImage = [textureImage CGImageForProposedRect: &rect context:nil hints:nil];
#endif
    
#if iOS
    spriteImage = [UIImage imageWithContentsOfFile:pathToTexture].CGImage;
#endif 
    
    if (!spriteImage) {
        [NSException raise:@"Exception while loading a texture"
                    format:@"Failed to load image %@", pathToTexture];
    }
    
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
    
    GLubyte * spriteData = (GLubyte *) malloc(width*height*4*sizeof(GLubyte));
    
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4,
                                                       CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(spriteContext, 0, height);
    CGContextScaleCTM(spriteContext, 1.0, -1.0);
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    
    CGContextRelease(spriteContext);
    MSTexture* textureToReturn = [[MSTexture alloc] initWithData:spriteData width:width height:height name: nam];
    return textureToReturn;
}

@end
