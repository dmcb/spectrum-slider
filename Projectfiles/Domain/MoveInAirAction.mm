//
//  MoveInAirAction.m
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoveInAirAction.h"
#import "PlayerActionContext.h"
#import "Player.h"
#import "CollisionVolume.h"

@implementation MoveInAirAction

- (id)initWithDirection:(CGPoint)aDirection
{
    aDirection = ccp(aDirection.x * 0.25f, aDirection.y * 0.25f);

    self = [super initWithDirection:aDirection];
    if (self) {

    }

    return self;
}


- (void)doAction:(PlayerActionContext *)actionContext delta:(float)delta
{
    // What's this about Kyle? Hacky stuff here
    if (actionContext.player.collisionVolume.body->GetLinearVelocity().y > 2.0f) {
        [super doAction:actionContext delta:delta];
    } else {
        [actionContext.player setIsOnGroundWithBool:true];
    }
    
    done = true;
}

@end
