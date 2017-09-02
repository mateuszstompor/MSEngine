//
//  MSTexture.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 11/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSTexture.h"


@implementation MSTexture

-(instancetype)initWithData: (unsigned char*) dat
                      width: (size_t) wid height: (size_t) hei name: (NSString*) nam{
    self = [super init];
    if (self){
        self->data = dat;
        self->width = wid;
        self->height = hei;
        self->_name = [[NSString alloc] initWithString:nam];
    }
    return self;
}

-(void)dealloc{
    free(self->data);
}

@end

