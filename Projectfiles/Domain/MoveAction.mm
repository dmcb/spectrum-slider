//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MoveAction.h"
#import "PlayerActionContext.h"
#import "Player.h"
#import "CollisionVolume.h"


@implementation MoveAction {

}

- (id)initWithDirection:(CGPoint)aDirection {
    self = [super init];
    if (self) {
        direction = aDirection;
        done = false;
    }
    return self;
}

- (bool)isDone {
    return done;
}

- (BOOL)isAtMaximumVelocity:(Player *)player body:(b2Body *)body {
    return fabs(body->GetLinearVelocity().x) >= [player maximumXVelocity];
}

- (void)doAction:(PlayerActionContext *)actionContext delta:(float)delta {
    Player *player = [actionContext player];

    b2Body *body = player.collisionVolume.body;
    b2Fixture *fixture = player.collisionVolume.fixture;

    b2Vec2 movementVector = b2Vec2(direction.x, direction.y);

    if (![self isAtMaximumVelocity:player body:body]) {

        fixture->SetFriction(0.26f);

        movementVector *= [player moveSpeed];

        if (body != nil) {
            body->SetAwake(true);
            body->ApplyLinearImpulse(movementVector, body->GetPosition());
        }

    }

    done = true;

}
@end