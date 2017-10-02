//
//  MSMaterial.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSMaterial.h"

@implementation MSMaterial

@synthesize name = _name;
@synthesize ambient = _ambient;
@synthesize diffuse = _diffuse;
@synthesize specular = _specular;
@synthesize shininess = _shininess;
@synthesize transparency = _transparency;
@synthesize renderMode = _renderMode;
@synthesize refraction = _refraction;
@synthesize associatedTextureName = _associatedTextureName;

-(instancetype)init{
    self = [super init];
    if(self != nil){
        self->_name=nil;
        self->_ambient=nil;
        self->_diffuse=nil;
        self->_specular=nil;
        self->_shininess=0;
        self->_transparency=0;
        self->_renderMode=COLOR_ON_AMBIENT_OFF;
        self->_refraction=0;
        self->_associatedTextureName=nil;
    }
    return self;
}

@end
