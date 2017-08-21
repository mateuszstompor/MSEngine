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
    unsigned int width;
    unsigned int height;
}

@property (atomic) NSString* name;

-(instancetype)initWithData: (unsigned char*) data width: (unsigned int) width height: (unsigned int) height;

@end

#endif
