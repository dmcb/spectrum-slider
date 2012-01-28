//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ObjectManager.h"

@implementation ObjectManager {

}

@synthesize objectsInPlay;

- (id)init {
    self = [super init];
    if (self) {
        objectsInPlay = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addObjectToPlay:(id <Updateable>)unit {
    [objectsInPlay addObject:unit];
}

- (void)removeObjectFromPlay:(id <Updateable>)unit {
    [objectsInPlay removeObject:unit];
}

- (void)update:(ccTime)delta {
    for (id object in objectsInPlay) {
        [object update:delta];
    }
}


@end