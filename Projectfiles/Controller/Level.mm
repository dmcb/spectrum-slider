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


@implementation Level
{

}

@synthesize hudLayer;
@synthesize player;
@synthesize dimension;


- (GameWorldLayer *)gameWorldLayer
{
    return gameWorldLayer;
}

- (b2Body *)initBody:(b2BodyDef *)fixture
{
    return [collisionManager initBody:fixture];
}

- (void)initStaticBodies:(CCTMXTiledMap *)map collisionLayer:(NSString *)clLayer collisionGroupId:(uint16)collisionGroupId
{
    return [collisionManager initStaticBodies:map collisionLayer:clLayer collisionGroupId:collisionGroupId];
}

- (void)initMovingObjects:(CCTMXTiledMap *)map
{
    [collisionManager initMovingObjects:map];
}

- (void)changeCollisionGroupForLevel:(uint16)newCollisionGroup
{
    [objectManager changeCollisionGroupIds:newCollisionGroup];
}

- (void)spawn:(id <Updateable, Displayable>)objectToSpawn
{
    [[gameWorldLayer playerLayer] addChild:[objectToSpawn display]];
    [objectManager addObjectToPlay:objectToSpawn];
}

- (void)addObjectToPlay:(id <Updateable>)objectToAdd
{
    [objectManager addObjectToPlay:objectToAdd];
}

- (id)init
{
    self = [super init];
    if (self) {
        collisionManager = [CollisionManager new];
        objectManager = [ObjectManager new];
        gameWorldLayer = [[GameWorldLayer alloc] initWithTileMap:@"level01.tmx"];
    }

    return self;
}

- (void)update:(ccTime)delta
{
    [hudLayer update:delta];
    [collisionManager update:delta];
    [objectManager update:delta];
}

- (void)drawDebugData
{
    [collisionManager draw];
}

- (void)enableDebugDraw:(GLESDebugDraw *)draw
{
    [collisionManager world]->SetDebugDraw(draw);
}


- (void)setDimension:(PrimaryColourDimension *)aDimension
{

    dimension = aDimension;

    if ([aDimension.colour isEqualToString:@"red"]) {
        [[gameWorldLayer yellowDimension] deactivate];
        [[gameWorldLayer blueDimension] deactivate];
        [[gameWorldLayer redDimension] activate];

    }
    else if ([aDimension.colour isEqualToString:@"yellow"]) {
        [[gameWorldLayer redDimension] deactivate];
        [[gameWorldLayer blueDimension] deactivate];
        [[gameWorldLayer yellowDimension] activate];
    }
    else {
        [[gameWorldLayer redDimension] deactivate];
        [[gameWorldLayer yellowDimension] deactivate];
        [[gameWorldLayer blueDimension] activate];

    }
}
@end