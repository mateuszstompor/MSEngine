//
//  MSLightSource.m
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 03/05/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import "MSLightSource.h"

@implementation MSLightSource
-(instancetype)initWithModel: (NSArray<MSModelFraction*>*)md andColor:(MSVector3D*) col{
    self=[self initWithScale:[MSMatrix4D identityMatrix:4] rotation:[MSMatrix4D identityMatrix:4] translation:[MSMatrix4D identityMatrix:4] model:md andColor:col];
    return self;
}
-(instancetype)initWithScale: (MSMatrix4D*)scaleM rotation: (MSMatrix4D*)rotationM translation:(MSMatrix4D*)trM model: (NSArray<MSModelFraction*>*)mod andColor:(MSVector3D*) col{
    self=[super initWithScale:scaleM rotation:rotationM translation:trM model:mod];
    if(self){
        color = [[MSVectorND alloc] initWithVector:col];
    }
    return self;
}
-(void)setColor: (MSVector3D*)col{
    self->color=col;
}
-(MSVector3D*)getColor{
    return self->color;
}
@end
