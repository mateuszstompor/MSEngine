//
//  MSMaterial.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/06/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSVectorND.h"

//0. Color on and Ambient off
//1. Color on and Ambient on
//2. Highlight on
//3. Reflection on and Ray trace on
//4. Transparency: Glass on, Reflection: Ray trace on
//5. Reflection: Fresnel on and Ray trace on
//6. Transparency: Refraction on, Reflection: Fresnel off and Ray trace on
//7. Transparency: Refraction on, Reflection: Fresnel on and Ray trace on
//8. Reflection on and Ray trace off
//9. Transparency: Glass on, Reflection: Ray trace off
//10. Casts shadows onto invisible surfaces





#ifndef MSMATERIAL_H
#define MSMATERIAL_H


typedef NS_ENUM(NSUInteger, RenderMode) {
    COLOR_ON_AMBIENT_OFF,
    COLOR_ON_AMBIENT_ON,
    HIGHLIGHT_ON,
    REFL_ON_RAY_TRACE_ON,
    GLASS_ON_RAY_TRACE_ON,
    FRENSEL_ON_RAY_TRACE_ON,
    REFRACTION_ON_FRENSEL_OFF_RAY_TRACE_ON,
    REFRACTION_ON_FRENSEL_ON_RAY_TRACE_ON,
    REFLECTION_ON_RAY_TRACE_OFF,
    GLASS_ON_RAY_TRACE_OFF,
    CAST_SHADOWS_ON_INVISIBLE_SURFACES
};



@interface MSMaterial : NSObject

    @property (atomic) NSString* name;
    @property (atomic) MSVector3D* ambient;
    @property (atomic) MSVector3D* diffuse;
    @property (atomic) MSVector3D* specular;
    @property (atomic) MSVector3D* emissive;
    @property (atomic) float shininess;
    @property (atomic) float transparency;
    @property (atomic) RenderMode renderMode;
    @property (atomic) float refraction;
    @property (atomic) NSString* associatedTexture;

-(instancetype)init;

@end


//description of mtl file

//Ns = Phong specular component. Ranges from 0 to 1000.
//Kd = Diffuse color weighted by the diffuse coefficient.
//Ka = Ambient color weighted by the ambient coefficient.
//Ks = Specular color weighted by the specular coefficient.
//Ke Ke stands for emissive coeficient
//d = Dissolve factor (pseudo-transparency). Values are from 0-1. 0 is completely transparent, 1 is opaque.
//Ni = Refraction index. Values range from 1 upwards. A value of 1 will cause no refraction. A higher value implies
//refraction.
//illum = (0, 1, or 2) 0 to disable lighting, 1 for ambient & diffuse only (specular color set to black), 2 for
//full lighting (see below)
//sharpness = ? (see below)
//map_Kd = Diffuse color texture map.
//map_Ks = Specular color texture map.
//map_Ka = Ambient color texture map.
//map_Bump = Bump texture map.
//map_d = Opacity texture map.
//refl = reflection type and filename (?)

#endif
