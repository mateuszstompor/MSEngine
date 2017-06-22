//
//  MSMaterial.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSMaterial.h"

@implementation MSMaterial

-(instancetype)init{
    self = [super init];
    if(self != nil){
        self->name=nil;
        self->ambient=nil;
        self->diffuse=nil;
        self->specular=nil;
        shininess=0;
        transparency=0;
        mode=COLOR_ON_AMBIENT_OFF;
        refraction=0;
        associatedTexture=nil;
    }
    return self;
}
-(void)setName: (NSString*) nam{
    self->name=nam;
}
-(NSString*)getName{
    return self->name;
}
-(void)setAmbient: (MSVector3D*)amb{
    self->ambient=amb;
}
-(MSVector3D*)getAmbient{
    return self->ambient;
}
-(void)setDiffuse: (MSVector3D*)dif{
    self->diffuse=dif;
}
-(MSVector3D*)getDiffuse{
    return self->diffuse;
}
-(void)setShininess: (float)shin{
    self->shininess=shin;
}
-(float)getShininess{
    return self->shininess;
}
-(void)setRenderMode:(RenderMode)mod{
    self->mode=mod;
}
-(RenderMode)getRenderMode{
    return self->mode;
}
-(void)setRefraction: (float)refrac{
    self->refraction=refrac;
}
-(float)getRefraction{
    return self->refraction;
}
-(void)setAssociatedTexture: (NSString*)texture{
    self->associatedTexture=texture;
}
-(NSString*)getAssociatedTexture{
    return self->associatedTexture;
}
-(void)setSpecular: (MSVector3D*)spec{
    self->specular=spec;
}
-(MSVector3D*)getSpecular{
    return self->specular;
}
-(void)setEmissive: (MSVector3D*)em{
    self->emissive=em;
}
-(MSVector3D*)getEmissive{
    return self->emissive;
}
-(void)setTransparency: (float)transp{
    self->transparency=transp;
}
-(float)getTransparency{
    return self->transparency;
}
@end
