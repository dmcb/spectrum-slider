//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Level.h"
#import "CollisionManager.h"
#import "ObjectManager.h"


@implementation Level {

}

- (b2Body)initBody:(b2BodyDef *)fixture {
    return [collisionManager initBody:fixture];
}

- (id)init {
    self = [super init];
    if (self) {
        collisionManager = [CollisionManager new];
        objectManager = [ObjectManager new];
    }

    return self;
}

- (void) update:(ccTime)delta {

    for (id object in [objectManager objectsInPlay]) {
        [object update:delta];
    }


}

@end