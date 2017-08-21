//
//  MSTexture.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 11/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSTexture.h"


@implementation MSTexture

@synthesize name = _name;

-(instancetype)initWithData: (unsigned char*) dat width: (unsigned int) wid height: (unsigned int) hei {
    self = [super init];
    if (self){
        self->data = dat;
        self->width = wid;
        self->height = hei;
        self->_name = nil;
    }
    return self;
}

-(void)dealloc{
    free(self->data);
}

@end

