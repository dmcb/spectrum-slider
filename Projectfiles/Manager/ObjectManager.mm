//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ObjectManager.h"
#import "Player.h"
#import "CollisionVolume.h"
#import "MovingObject.h"

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

- (void) changeCollisionGroupIds:(uint16) collisionGroup {

    for (id object in objectsInPlay) {
        if ([object isKindOfClass:[Player class]]) {
            [[object collisionVolume] setCollisionGroupId:collisionGroup];
        } else if ([object isKindOfClass:[MovingObject class]]) {
            [object setCollisionGroupId:collisionGroup];
        }
    }
}

- (void)update:(ccTime)delta {
    for (id object in objectsInPlay) {
        [object update:delta];
    }
}


@end