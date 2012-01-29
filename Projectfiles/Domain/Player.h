//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Updateable.h"
#import "Displayable.h"

@class PlayerActionContext;
@class CollisionVolume;


@interface Player : CCNode <Updateable, Displayable> {
    PlayerActionContext *actionContext;
    CollisionVolume *collisionVolume;
    CCSprite *sprite;
}

@property(nonatomic, strong) CollisionVolume *collisionVolume;

- (void)spawn;

- (void)moveInDirection:(CGPoint)directionVector;

- (float)moveSpeed;

- (bool)isMoving;

- (void)stopXMovement;

- (void)jump;

@end