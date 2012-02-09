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
#import "DynamicallyColourable.h"

const float PTM_RATIO = 32.0f;

@interface MovingObject : CCNode <Updateable, Displayable, DynamicallyColourable> {

    CCSprite *sprite;

    b2Body *body;
    b2Fixture *fixture;

    uint16 cid;

    NSString *triggerName;
}

@property(nonatomic) b2Fixture *fixture;
@property(nonatomic) b2Body *body;

- (id)initWithTriggerName:(NSString *)aTriggerName;

- (void)setCollisionGroupId:(uint16)newCollisionGroup;

- (void)trigger;

- (void)spawn;

@end
