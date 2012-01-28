//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Player.h"
#import "PlayerActionContext.h"
#import "CollisionVolume.h"

@implementation Player {

}

- (id)init {
    self = [super init];

    if (self) {
        actionContext = [PlayerActionContext new];
    }

    return self;
}

- (void)update:(ccTime)delta {
    [collisionVolume update:delta];
}

@end