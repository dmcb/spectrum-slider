//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Updateable.h"
#import "Box2D.h"

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
}

@property(nonatomic, strong) HUDLayer *hudLayer;
@property(nonatomic, strong) Player *player;

- (GameWorldLayer *)gameWorldLayer;

- (b2Body *)initBody:(b2BodyDef *)fixture;

- (void)spawn:(id <Updateable, Displayable>)objectToSpawn;

@end