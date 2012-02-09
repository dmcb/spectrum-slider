//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Updateable.h"
#import "Displayable.h"

@class PlayerActionContext;
@class PlayerCollisionVolume;


@interface Player : CCNode <Updateable, Displayable> {
    PlayerActionContext *actionContext;
    PlayerCollisionVolume *collisionVolume;
    CCSprite *sprite;
    bool isOnGround;
}

@property(nonatomic, strong) PlayerCollisionVolume *collisionVolume;

- (void)spawn;

- (void)moveInDirection:(CGPoint)directionVector;

- (void)moveInDirectionWhileInAir:(CGPoint)directionVector;

- (float)moveSpeed;

- (bool)isMoving;

- (void)stopXMovement;

- (void)jump;

- (void)setIsOnGround:(NSNumber *)value;

- (void)setIsOnGroundWithBool:(bool) value;

- (NSNumber *)isOnGroundObjectReturnValue;

- (bool) isOnGround;

- (void)frictionizeMotion;

- (void)giveASlightBoost;

- (float)maximumXVelocity;

- (float)jumpVelocity;

- (BOOL)canJump;
@end