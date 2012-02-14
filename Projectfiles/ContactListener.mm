/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim.
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "ContactListener.h"
#import "cocos2d.h"
#import "Player.h"
#import "Triggerable.h"
#import "Domain/PlayerCollisionVolume.h"
#import "HeadSensor.h"

void setPlayerJustLanded (b2Contact *contact, NSObject *nodeToCheck) {
    if ([nodeToCheck respondsToSelector:@selector(setIsOnGround:)]) {
        if ([[nodeToCheck performSelector:@selector(isOnGroundObjectReturnValue)] boolValue] == false) {

            b2WorldManifold manifold;
            contact->GetWorldManifold(&manifold);

            //NSLog(@"----------------------------------------");
            //NSLog(@" player y=%f", playerPosition.y);

            float32 value = manifold.normal.y;
            bool below = value > 0.0f || (value < 0.0f && value > -1.0f);

            //NSLog(@"----------------------------------------");
            NSNumber *passedValue = [NSNumber numberWithBool:below];

            if (below) {
                if ([nodeToCheck respondsToSelector:@selector(giveASlightBoost)]) {
                    [nodeToCheck performSelector:@selector(giveASlightBoost)];
                }
                [nodeToCheck performSelector:@selector(setIsOnGround:) withObject:passedValue];
            }

        }
    }
}

void ContactListener::BeginContact (b2Contact *contact) {
    NSObject *nodeA = (__bridge NSObject *) contact->GetFixtureA()->GetUserData();
    NSObject *nodeB = (__bridge NSObject *) contact->GetFixtureB()->GetUserData();

    if (nodeA != NULL) {
        setPlayerJustLanded(contact, nodeA);
    }

    if (nodeB != NULL) {
        setPlayerJustLanded(contact, nodeB);
    }

    if ([nodeA respondsToSelector:@selector(setIsCollidingWithSomething:)]) {
        [((id) nodeA) setIsCollidingWithSomething:true];
    }


    if ([nodeB respondsToSelector:@selector(setIsCollidingWithSomething:)]) {
        [((id) nodeB) setIsCollidingWithSomething:true];
    }
}

void ContactListener::EndContact (b2Contact *contact) {
    b2Body *bodyA = contact->GetFixtureA()->GetBody();
    b2Body *bodyB = contact->GetFixtureB()->GetBody();
    CCNode *spriteA = (__bridge CCNode *) bodyA->GetUserData();
    CCNode *spriteB = (__bridge CCNode *) bodyB->GetUserData();

    NSObject *fixtureAColliding = (__bridge NSObject *) contact->GetFixtureA()->GetUserData();
    if ([fixtureAColliding respondsToSelector:@selector(setIsCollidingWithSomething:)]) {
        [((id) fixtureAColliding) setIsCollidingWithSomething:false];
    }

    NSObject *fixtureBColliding = (__bridge NSObject *) contact->GetFixtureB()->GetUserData();
    if ([fixtureBColliding respondsToSelector:@selector(setIsCollidingWithSomething:)]) {
        [((id) fixtureBColliding) setIsCollidingWithSomething:false];
    }
}
