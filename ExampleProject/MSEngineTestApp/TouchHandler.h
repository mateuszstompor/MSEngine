//
//  TouchHandler.h
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 12/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rotator.h"
#import <UIKit/UIKit.h>

#ifndef TouchHandler_h
#define TouchHandler_h

@interface TouchHandler : NSObject <Rotator>
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initOn: (UIView*) parentView frame: (CGRect) frame;
@end

#endif
