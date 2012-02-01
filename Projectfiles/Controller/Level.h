//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Updateable.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "ColorDimension.h"

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
    ColorDimension *dimension;
}

@property(nonatomic, strong) HUDLayer *hudLayer;
@property(nonatomic, strong) Player *player;
@property(nonatomic, strong) ColorDimension *dimension;

- (GameWorldLayer *)gameWorldLayer;

- (b2Body *)initBody:(b2BodyDef *)fixture;

- (void)initStaticBodies:(CCTMXTiledMap *)map collisionLayer:(NSString *)clLayer collisionGroupId:(uint16)collisionGroupId;

- (void)initMovingObjects:(CCTMXTiledMap *)map;

- (void)changeCollisionGroupForLevel:(uint16)newCollisionGroup;

- (void)spawn:(id <Updateable, Displayable>)objectToSpawn;

- (void)drawDebugData;

- (void)enableDebugDraw:(GLESDebugDraw *)draw;
@end