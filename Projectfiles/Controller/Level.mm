//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Level.h"
#import "CollisionManager.h"
#import "ObjectManager.h"
#import "GameWorldLayer.h"
#import "Displayable.h"
#import "Player.h"
#import "HUDLayer.h"


@implementation Level {

}

@synthesize hudLayer;
@synthesize player;


- (GameWorldLayer *) gameWorldLayer {
    return gameWorldLayer;
}

- (b2Body *)initBody:(b2BodyDef *)fixture {
    return [collisionManager initBody:fixture];
}

- (void)spawn:(id <Updateable, Displayable>)objectToSpawn {
    [gameWorldLayer addObjectToGame:[objectToSpawn display]];
    [objectManager addObjectToPlay:objectToSpawn];
}

- (id)init {
    self = [super init];
    if (self) {
        collisionManager = [CollisionManager new];
        objectManager = [ObjectManager new];
        gameWorldLayer = [[GameWorldLayer alloc] init];
    }

    return self;
}

- (void) update:(ccTime)delta {
    [hudLayer update:delta];
    [collisionManager update:delta];
    [objectManager update:delta];
}

@end