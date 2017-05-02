//
//  MSModelManager.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 21/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSModelFraction.h"

#ifndef MSMODELMANAGER_H
#define MSMODELMANAGER_H
@protocol MSModelManager
+(NSArray<MSModelFraction*>*)loadModel: (const char*)path;
@end
#endif
