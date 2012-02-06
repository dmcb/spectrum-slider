//
//  Axe.m
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Axe.h"
#import "GameContext.h"
#import "Level.h"

@implementation Axe

- (id)initWithWidth:(float32)aWidth height:(float32)aHeight axeHeight:(float32)anAxeHeight
{
    self = [super init];
    if (self) {
        width = aWidth;
        height = aHeight;
        axeHeight = anAxeHeight;
    }

    return self;
}

- (void)update:(ccTime)delta
{

    float32 currentVelocity = body->GetAngularVelocity();

    if (fabs(currentVelocity) < 4) {
        currentVelocity += 1;
    }

    body->ApplyAngularImpulse(currentVelocity);

    [super update:delta];

    sprite.rotation +=90;
}


- (void)spawn
{

    sprite = [CCSprite spriteWithFile:@"test_crate_sprite.png"];


    [sprite setScaleX:width / sprite.contentSize.width];
    [sprite setScaleY:axeHeight / sprite.contentSize.height];

    b2BodyDef pivotBodyDef;
    pivotBodyDef.type = b2_staticBody;
    pivotBodyDef.position.Set(self.position.x / PTM_RATIO, self.position.y / PTM_RATIO);

    Level *currentLevel = [[GameContext sharedContext] currentLevel];

    pivotBody = [currentLevel initBody:&pivotBodyDef];

    b2CircleShape pivotShape;
    pivotShape.m_p.Set(0.2f / PTM_RATIO, 0.2f / PTM_RATIO);
    pivotShape.m_radius = 1.0f;

    b2FixtureDef shapeDef;
    shapeDef.shape = &pivotShape;

    pivotBody->CreateFixture(&shapeDef);

    b2BodyDef axeHandleBodyDef;
    axeHandleBodyDef.type = b2_dynamicBody;
    axeHandleBodyDef.position.Set((self.position.x + axeHeight) / PTM_RATIO, (self.position.y) / PTM_RATIO);

    axeHandleBody = [currentLevel initBody:&axeHandleBodyDef];

    b2PolygonShape axeShape;
    axeShape.SetAsBox(axeHeight / PTM_RATIO, width / PTM_RATIO);

    b2FixtureDef axeFixtureDef;
    axeFixtureDef.shape = &axeShape;
    axeFixtureDef.density = 2.0f;
    axeFixtureDef.restitution = 0.0f;

    fixture = axeHandleBody->CreateFixture(&axeFixtureDef);

    b2RevoluteJointDef revoluteJointDef;
    revoluteJointDef.bodyA = pivotBody;
    revoluteJointDef.bodyB = axeHandleBody;

    b2Vec2 vec2;
    vec2.Set(self.position.x / PTM_RATIO, self.position.y / PTM_RATIO);

    revoluteJointDef.Initialize(pivotBody, axeHandleBody, vec2);

    [currentLevel initJoint:&revoluteJointDef];

    body = axeHandleBody;

    [super spawn];
}


@end
