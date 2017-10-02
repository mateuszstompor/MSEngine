//
//  MSpuppet.h
//  MSGraphicsEngine
//
//  Created by Mateusz Stompór on 24/04/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MSPositionedObject.h"
#import "MSModelFraction.h"

#ifndef MSPUPPET_H
#define MSPUPPET_H
@interface MSPuppet : NSObject
{
    NSArray<MSModelFraction*>* model;
}
-(instancetype _Nonnull)init NS_UNAVAILABLE;
-(NSArray<MSModelFraction*>* _Nonnull)getModelComponents;
-(instancetype _Nullable)initWithModel: (NSArray<MSModelFraction*>* _Nonnull)mod;
@end
#endif
