//
//  MoveableObject.h
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "Updateable.h"
#import "Displayable.h"

const float PTM_RATIO = 32.0f;

@interface MovingObject : CCNode <Updateable, Displayable> {

    CCSprite *sprite;

    b2Body *body;
    b2Fixture *fixture;

    uint16 cid;
}

@property(nonatomic) b2Fixture *fixture;
@property(nonatomic) b2Body *body;

- (void)setCollisionGroupId:(uint16)newCollisionGroup;

- (void)spawn;

@end
