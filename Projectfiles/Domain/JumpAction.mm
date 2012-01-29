//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "JumpAction.h"
#import "Player.h"
#import "PlayerActionContext.h"
#import "CollisionVolume.h"


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

    b2Body *body = [[player collisionVolume] body];

    b2Vec2 vec2;

    vec2.y = 1000;

    body->ApplyLinearImpulse(vec2, body->GetWorldCenter());

    done = true;

}
@end