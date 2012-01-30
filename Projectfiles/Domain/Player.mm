//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Player.h"
#import "PlayerActionContext.h"
#import "CollisionVolume.h"
#import "GameContext.h"
#import "Level.h"
#import "MoveAction.h"
#import "JumpAction.h"

@implementation Player {

}

@synthesize collisionVolume;


- (id)init {
    self = [super init];

    if (self) {
        actionContext = [PlayerActionContext new];
        [actionContext setPlayer:self];
        sprite = [CCSprite spriteWithFile:@"player.png"];
    }

    return self;
}

- (void)update:(ccTime)delta {
    [collisionVolume update:delta];
    [actionContext doAction:delta];
    [sprite setPosition:[self position]];
    [sprite setRotation:[self rotation]];
}

- (void)spawn {
    collisionVolume = [[CollisionVolume alloc] initWithGameObject:self collisionGroupId:0 width:sprite.contentSize.width height:sprite.contentSize.height];
    [[[GameContext sharedContext] currentLevel] spawn:self];
    [[[GameContext sharedContext] currentLevel] setPlayer:self];
}

- (void)moveInDirection:(CGPoint)directionVector {
    [actionContext setAction:[[MoveAction alloc] initWithDirection:directionVector]];
}

- (float)moveSpeed {
    return 12.0f;
}

- (bool)isMoving {
    return [actionContext isCurrentActionType:[MoveAction class]];
}


- (CCSprite *)display {
    return sprite;
}

- (void)stopXMovement {
    if ([actionContext isCurrentActionType:[MoveAction class]]) {
        [actionContext stopAllActions];
    }
}

-(void) jump {
    [actionContext setAction:[[JumpAction alloc] init]];
}

-(void) setIsOnGround:(NSNumber *) value {
    isOnGround = [value boolValue];
}

- (void)setIsOnGroundWithBool:(bool)value {
    isOnGround = value;
}

-(NSNumber *) isOnGroundObjectReturnValue {
    return [NSNumber numberWithBool:isOnGround];
}

- (bool)isOnGround {
    return isOnGround;
}

- (void)frictionizeMotion {
    if (isOnGround) {
        b2Fixture *fixture = collisionVolume.fixture;
        fixture->SetFriction(1.0f);
    }
}

- (void) giveASlightBoost {
    
    float32 xVelocity = collisionVolume.body->GetLinearVelocity().x;

    float tinyBoostVelocity = 0;
    if (xVelocity > 0) {
        tinyBoostVelocity = 5.0f;
    } else if (xVelocity < 0) {
        tinyBoostVelocity = -5.0f;
    }

    [actionContext setAction:[[MoveAction alloc] initWithDirection:ccp(tinyBoostVelocity, 0)]];

}

- (float) maximumXVelocity {
    return 5.0f;
}

@end