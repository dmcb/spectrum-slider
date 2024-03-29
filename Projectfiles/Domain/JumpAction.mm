//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "JumpAction.h"
#import "Player.h"
#import "PlayerActionContext.h"
#import "PlayerCollisionVolume.h"


@implementation JumpAction {

}

- (id)init {
    self = [super init];
    if (self) {
        done = false;
    }

    return self;
}


- (bool)isDone {
    return done;
}

- (void)doAction:(PlayerActionContext *)actionContext delta:(float)delta {

    Player *player = [actionContext player];

    [player setIsOnGroundWithBool:false];

    b2Body *body = [[player collisionVolume] body];

    b2Fixture *fixture = [[player collisionVolume] fixture];

    fixture->SetFriction(0.2f);

    b2Vec2 worldCenter = body->GetPosition();

    b2Vec2 vec2;
    vec2.y = [player jumpVelocity];
    vec2.x = 0;

    body->ApplyLinearImpulse(vec2, worldCenter);

    done = true;

}
@end