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


- (GameWorldLayer *)gameWorldLayer {
    return gameWorldLayer;
}

- (b2Body *)initBody:(b2BodyDef *)fixture {
    return [collisionManager initBody:fixture];
}

- (void)initStaticBodies:(CCTMXTiledMap *)map collisionLayer:(NSString *)clLayer collisionGroupId:(int)collisionGroupId {
    return [collisionManager initStaticBodies:map collisionLayer:clLayer collisionGroupId:collisionGroupId];
}

- (void)spawn:(id <Updateable, Displayable>)objectToSpawn {
    [[gameWorldLayer playerLayer] addChild:[objectToSpawn display]];
    [objectManager addObjectToPlay:objectToSpawn];
}

- (id)init {
    self = [super init];
    if (self) {
        collisionManager = [CollisionManager new];
        objectManager = [ObjectManager new];
        gameWorldLayer = [[GameWorldLayer alloc] initWithTileMap:@"level01.tmx"];
    }

    return self;
}

- (void)update:(ccTime)delta {
    [hudLayer update:delta];
    [collisionManager update:delta];
    [objectManager update:delta];
}

-(void) drawDebugData {
    [collisionManager draw];
}

- (void)enableDebugDraw:(GLESDebugDraw *)draw {
    [collisionManager world]->SetDebugDraw(draw);
}
@end