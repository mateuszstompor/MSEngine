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
                      width: (int) wid height: (int) hei name: (NSString*) nam{
    self = [super init];
    if (self){
        self->data = dat;
        self->width = wid;
        self->height = hei;
        self->name = [[NSString alloc] initWithString:nam];
    }
    return self;
}

-(void)dealloc{
    free(self->data);
}
-(NSString*)getName {
    return self->name;
}
@end

