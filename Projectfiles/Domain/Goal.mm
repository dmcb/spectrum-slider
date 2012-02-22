//
//  Goal.m
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Goal.h"
#import "b2Body.h"
#import "GameContext.h"
#import "Level.h"
#import "b2CircleShape.h"

@implementation Goal

- (id)init
{
    self = [super init];
    if (self) {

    }

    return self;
}

- (void)spawn
{
    sprite = [CCSprite spriteWithFile:@"goal_sprite.png"];

    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(self.position.x / PTM_RATIO, self.position.y / PTM_RATIO);
    bodyDef.bullet = true;

    bodyDef.userData = (__bridge void *) sprite;

    body = [[[GameContext sharedContext] currentLevel] initBody:&bodyDef];

    b2PolygonShape collisionShape;
    collisionShape.SetAsBox(sprite.contentSize.width / PTM_RATIO * 0.5, sprite.contentSize.height / PTM_RATIO * 0.5);

    // todo make these parameters. (density and such)

    b2FixtureDef shapeDef;
    shapeDef.shape = &collisionShape;
    shapeDef.density = 300.0f;
    shapeDef.restitution = 0.0f;
    shapeDef.userData = (__bridge void *) self;

    fixture = body->CreateFixture(&shapeDef);

    fixture->SetFriction(0.1f);

    [super spawn];
}

@end
