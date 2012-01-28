//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Updateable.h"

@class CollisionManager;
@class ObjectManager;
@class GameWorldLayer;
@protocol Displayable;


@interface Level : NSObject <Updateable> {

    CollisionManager *collisionManager;
    ObjectManager *objectManager;

    GameWorldLayer *gameWorldLayer;
}

-(GameWorldLayer *) gameWorldLayer;
-(b2Body *) initBody:(b2BodyDef *) fixture;

- (void)spawn:(id <Updateable, Displayable>) objectToSpawn;

@end