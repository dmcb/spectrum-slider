//
//  TriggerManager.h
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Triggerable;

@class Trigger;

@interface TriggerManager : NSObject {

    NSMutableArray *triggers;

}

- (bool)doesTriggerExist:(NSString *)triggerKey;

- (void)createTrigger:(NSString *)triggerKey;

- (void)registerTriggerableWithTrigger:(id <Triggerable>)triggerable triggerKey:(NSString *)triggerKey;

- (Trigger *)triggerForKey:(NSString *)key;


@end
