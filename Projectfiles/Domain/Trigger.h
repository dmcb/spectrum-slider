//
//  Trigger.h
//  Spectrum-Slider
//
//

#import <Foundation/Foundation.h>

@protocol Triggerable;

@interface Trigger : NSObject
{
    NSString *key;

    NSMutableArray *listeners;

}

- (id)initWithKey:(NSString *)aKey;

- (NSString *)key;

- (void) addListener:(id<Triggerable>) listener;

- (void)doTrigger;

- (void)undoTrigger;

@end
