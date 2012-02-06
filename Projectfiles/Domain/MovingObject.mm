//
//  MoveableObject.m
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovingObject.h"
#import "GameContext.h"
#import "Level.h"



@implementation MovingObject

@synthesize fixture;
@synthesize body;

- (void)update:(ccTime)delta {
    b2Vec2 position = body->GetPosition();
    sprite.position = ccp(position.x * PTM_RATIO, position.y * PTM_RATIO);
    sprite.rotation = -1 * CC_RADIANS_TO_DEGREES(body->GetAngle());
}

- (void)setCollisionGroupId:(uint16)newCollisionGroup {

    if (cid == nil) {
        cid = newCollisionGroup;
    }

    b2Filter myFilterData = fixture->GetFilterData();


    if ([[NSNumber numberWithInt:cid & newCollisionGroup] isEqualToNumber:[NSNumber numberWithInt:0]]) {
        myFilterData.categoryBits = cid;
    } else {
        myFilterData.categoryBits = cid & newCollisionGroup;
        myFilterData.maskBits = 0xF | (cid & newCollisionGroup);
    }

    fixture->SetFilterData(myFilterData);
}

- (void)spawn {
    [[[GameContext sharedContext] currentLevel] addObjectToPlay:self];
}

- (CCSprite *)display {
    return sprite;
}

- (void)setDynamicColour:(ccColor3B)colour
{
    sprite.color = colour;
}


@end
