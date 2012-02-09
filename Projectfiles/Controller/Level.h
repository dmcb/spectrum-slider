//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Updateable.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "../Domain/PrimaryColourDimension.h"

@protocol Displayable;
@class CollisionManager;
@class ObjectManager;
@class GameWorldLayer;
@class Player;
@class HUDLayer;


@interface Level : NSObject <Updateable> {

    CollisionManager *collisionManager;
    ObjectManager *objectManager;

    HUDLayer *hudLayer;
    GameWorldLayer *gameWorldLayer;
    Player *player;
    PrimaryColourDimension *dimension;
}

@property(nonatomic, strong) HUDLayer *hudLayer;
@property(nonatomic, strong) Player *player;
@property(nonatomic, strong) PrimaryColourDimension *dimension;

- (GameWorldLayer *)gameWorldLayer;

- (b2Body *)initBody:(b2BodyDef *)fixture;

-(b2Joint *) initJoint:(b2JointDef *)jointDef;

- (void)initStaticBodies:(CCTMXTiledMap *)map collisionLayer:(NSString *)clLayer collisionGroupId:(uint16)collisionGroupId;

- (void)initMovingObjects:(CCTMXTiledMap *)map;

- (void) deleteBody:(b2Body *) bodyToDelete;

- (void)changeCollisionGroupForLevel:(uint16)newCollisionGroup;

- (void)spawn:(id <Updateable, Displayable>)objectToSpawn;

- (void)addObjectToPlay:(id <Updateable>)objectToAdd;

- (void)drawDebugData;

- (void)enableDebugDraw:(GLESDebugDraw *)draw;
@end