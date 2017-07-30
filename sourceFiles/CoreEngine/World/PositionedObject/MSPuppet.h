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
@interface MSPuppet : NSObject <MSPositionedObject>
{
    NSArray<MSModelFraction*>* model;
}
-(instancetype _Nullable)init NS_UNAVAILABLE;
-(instancetype _Nullable)initWithModel: (NSArray<MSModelFraction*>* _Nullable)md;
-(NSArray<MSModelFraction*>* _Nullable)getModelComponents;

@end
#endif
