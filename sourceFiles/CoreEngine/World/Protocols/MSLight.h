//
//  MSLight.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 10/08/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#ifndef MSLight_h
#define MSLight_h

@protocol MSLight

@property (atomic) MSVector3D* color;
@property (atomic) float power;

@end

#endif
