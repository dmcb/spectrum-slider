//
//  TriggerManager.m
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TriggerManager.h"
#import "Triggerable.h"
#import "Trigger.h"

@implementation TriggerManager
- (id)init
{
    self = [super init];
    if (self) {        
        triggers = [NSMutableArray new];        
    }
    return self;

}

- (bool) doesTriggerExist:(NSString *) triggerKey {

    for ( id trigger in triggers ) {
        if ([[trigger key] isEqualToString:triggerKey]) {
            return true;
        }
    }

    return false;
}

- (void) createTrigger:(NSString *) triggerKey
{
    if (![self doesTriggerExist:triggerKey]) {
        Trigger *trigger = [[Trigger alloc] initWithKey:triggerKey];

        [triggers addObject:trigger];
    }

}

- (void) registerTriggerableWithTrigger:(id<Triggerable>) triggerable triggerKey:(NSString *) triggerKey {

    for ( id trigger in triggers ) {
        if ([[trigger key] isEqualToString:triggerKey]) {
            [trigger addListener:triggerable];
        }
    }
}

- (Trigger *) triggerForKey:(NSString *) key {
    for ( id trigger in triggers ) {
        if ([[trigger key] isEqualToString:key]) {
            return trigger;
        }
    }
    return nil;
}

@end
