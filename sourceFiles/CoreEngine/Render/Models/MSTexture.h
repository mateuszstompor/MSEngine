//
//  MSTexture.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 11/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>



#ifndef MSTexture_h
#define MSTexture_h

@interface MSTexture : NSObject

{
    unsigned char * data;
    size_t width;
    size_t height;
}

@property (atomic) NSString* name;

-(instancetype)initWithData: (unsigned char*) data
                      width: (size_t) width height: (size_t) height name: (NSString*) name;

@end

#endif
