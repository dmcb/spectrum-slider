/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim.
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "ContactListener.h"
#import "cocos2d.h"
#import "Player.h"

void setIsOnGround(b2Contact *contact, b2Body *bodyToCheck, CCNode *nodeToCheck) {
    if ([nodeToCheck respondsToSelector:@selector(setIsOnGround:)]) {
        if ([[nodeToCheck performSelector:@selector(isOnGroundObjectReturnValue)] boolValue] == false) {
            b2Vec2 playerPosition = bodyToCheck->GetPosition();

            b2WorldManifold manifold;
            contact->GetWorldManifold(&manifold);

            NSLog(@"----------------------------------------");
            NSLog(@" player y=%f", playerPosition.y);

            bool below = manifold.normal.y >0;

            NSLog(@"----------------------------------------");
            NSNumber *passedValue = [NSNumber numberWithBool:below];

            if (below) {
                if (nodeToCheck) {

                }
            }

            
            [nodeToCheck performSelector:@selector(setIsOnGround:) withObject:passedValue];
        }
    }
}

void ContactListener::BeginContact(b2Contact *contact) {
    b2Body *bodyA = contact->GetFixtureA()->GetBody();
    b2Body *bodyB = contact->GetFixtureB()->GetBody();
    CCNode *nodeA = (__bridge CCNode *) bodyA->GetUserData();
    CCNode *nodeB = (__bridge CCNode *) bodyB->GetUserData();

    if (nodeA != NULL) {
        setIsOnGround(contact, bodyA, nodeA);
    } else if (nodeB != NULL) {
        setIsOnGround(contact, bodyB, nodeB);
    }
}

void ContactListener::EndContact(b2Contact *contact) {
    b2Body *bodyA = contact->GetFixtureA()->GetBody();
    b2Body *bodyB = contact->GetFixtureB()->GetBody();
    CCNode *spriteA = (__bridge CCNode *) bodyA->GetUserData();
    CCNode *spriteB = (__bridge CCNode *) bodyB->GetUserData();

    if (spriteA != NULL && spriteB != NULL) {

    }
}
