//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GameContext.h"
#import "Level.h"


@implementation GameContext {

}

@synthesize currentLevel;

+ (GameContext *)sharedContext {

    static GameContext *myInstance = nil;

    if (nil == myInstance) {
        myInstance = [[[self class] alloc] init];
    }

    return myInstance;

}

- (void)update:(float)delta {
    [[[GameContext sharedContext] currentLevel] update:delta];
}

@end