//
//  Trigger.m
//  Spectrum-Slider
//

#import "Trigger.h"
#import "Triggerable.h"

@implementation Trigger

- (id)initWithKey:(NSString *)aKey
{
    self = [super init];
    if (self) {
        key = aKey;
        listeners = [NSMutableArray new];
    }
    return self;
}

- (NSString *)key
{
    return key;
}

- (void)addListener:(id <Triggerable>)listener
{
    [listeners addObject:listener];
}

// todo not sure we'll need to do this?
//- (void) removeListener()

- (void)doTrigger
{
    for ( id listener in listeners ) {
        [listener doAction];
    }

}

- (void)undoTrigger
{
    for ( id listener in listeners ) {
        [listener undoAction];
    }
}

@end
