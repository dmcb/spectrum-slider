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
    }
    return self;
}

- (bool)isDone {
    return false;
}

- (void)doAction:(PlayerActionContext *)actionContext delta:(float)delta {
    Player *player = [actionContext player];

    b2Body *body = player.collisionVolume.body;

    b2Vec2 movementVector = b2Vec2(direction.x, direction.y);

//    movementVector.Normalize();

    movementVector *= [player moveSpeed];

    if (body != nil) {
        body->SetAwake(true);
//        body->SetAngularDamping(1.0f);   // and this keeps it from spinning wildly
        body->SetLinearDamping(5.0f);   // and this keeps it from moving wildly
        body->ApplyLinearImpulse(movementVector, body->GetPosition());
    }

}
@end