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
#import "TriggerManager.h"
#import "Trigger.h"
#import "Triggerable.h"
#import "WinLayer.h"
#import "CDAudioManager.h"
#import "GameContext.h"
#import "CombinationColourDimension.h"


@implementation Level
{

}

@synthesize hudLayer;
@synthesize player;
@synthesize dimension;


- (id)initWithScene:(CCScene *)scene tmxLevelId:(NSString *)aTmxLevelId
{
    self = [super init];
    if (self) {
        
        CCLayer *mainLayer = [[CCLayer alloc] init];
        
        [scene addChild:mainLayer];

        collisionManager = [CollisionManager new];
        objectManager = [ObjectManager new];
        triggerManager = [TriggerManager new];
        gameWorldLayer = [[GameWorldLayer alloc] initWithTileMap:aTmxLevelId];

        [[GameContext sharedContext] setCurrentLevel:self];

        hudLayer = [HUDLayer new];

        [mainLayer addChild:gameWorldLayer.tiledMap];
        [mainLayer addChild:gameWorldLayer.playerLayer];

        [mainLayer addChild:gameWorldLayer.redDimension.spriteLayer];
        [mainLayer addChild:gameWorldLayer.blueDimension.spriteLayer];
        [mainLayer addChild:gameWorldLayer.yellowDimension.spriteLayer];

        [mainLayer addChild:gameWorldLayer.orangeDimension.spriteLayer];
        [mainLayer addChild:gameWorldLayer.greenDimension.spriteLayer];
        [mainLayer addChild:gameWorldLayer.purpleDimension.spriteLayer];

        [self initStaticBodies:gameWorldLayer.tiledMap collisionLayer:@"Collision_ALL" collisionGroupId:0xF];
        [self initStaticBodies:gameWorldLayer.tiledMap collisionLayer:@"Collision_RED" collisionGroupId:0xF0];
        [self initStaticBodies:gameWorldLayer.tiledMap collisionLayer:@"Collision_BLUE" collisionGroupId:0xF00];
        [self initStaticBodies:gameWorldLayer.tiledMap collisionLayer:@"Collision_YELLOW" collisionGroupId:0xF000];

        [self initMovingObjects:gameWorldLayer.tiledMap];

        player = [[Player alloc] init];

        player.position = ccp(100, 100);

        [player spawn];

        [mainLayer addChild:hudLayer];

//        [scene enableBox2dDebugDrawing];

        // Level starts with red dimension
        [self setDimension:[gameWorldLayer redDimension]];
        tmxLevelId = aTmxLevelId;
    }
    return self;
}

- (GameWorldLayer *)gameWorldLayer
{
    return gameWorldLayer;
}

- (b2Body *)initBody:(b2BodyDef *)fixture
{
    return [collisionManager initBody:fixture];
}

- (b2Joint *)initJoint:(b2JointDef *)jointDef
{
    return [collisionManager initJoint:jointDef];
}

- (void)initStaticBodies:(CCTMXTiledMap *)map collisionLayer:(NSString *)clLayer collisionGroupId:(uint16)collisionGroupId
{
    return [collisionManager initStaticBodies:map collisionLayer:clLayer collisionGroupId:collisionGroupId];
}

- (void)initMovingObjects:(CCTMXTiledMap *)map
{
    [collisionManager initMovingObjects:map];
}

- (void)deleteBody:(b2Body *)bodyToDelete
{
    [collisionManager deleteBody:bodyToDelete];
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

- (Trigger *)createOrAddTrigger:(NSString *)triggerKey
{
    if ([triggerManager doesTriggerExist:triggerKey]) {
        return [triggerManager triggerForKey:triggerKey];
    } else {
        [triggerManager createTrigger:triggerKey];
        return [triggerManager triggerForKey:triggerKey];
    }
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

- (void)completeLevel
{
    [hudLayer setIgnoreInput:true];

    WinLayer *layer = [WinLayer new];

    layer.position = ccp(hudLayer.position.x + hudLayer.contentSize.width / 2, hudLayer.position.y + hudLayer.contentSize.height / 2);

    [hudLayer addChild:layer z:0];

    [[GameContext sharedContext] changeLevels:@"level02.tmx"];
}

@end