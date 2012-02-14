//
//  Button.m
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Button.h"
#import "GameContext.h"
#import "Level.h"
#import "Trigger.h"

@implementation Button

- (id)initWithTrigger:(Trigger *)aTrigger width:(float32)aWidth height:(float32)aHeight density:(float)aDensity
{
    self = [super init];
    if (self) {
        trigger = aTrigger;
        width = aWidth;
        height = aHeight;
        density = aDensity;
    }

    return self;
}

- (void)spawn
{
    sprite = [CCSprite spriteWithFile:@"test_crappy_button_sprite.png"];

    [sprite setScaleX:width / sprite.contentSize.width];
    [sprite setScaleY:height / sprite.contentSize.height];

    b2BodyDef triggerPlateBodyDef;
    triggerPlateBodyDef.type= b2_staticBody;
    triggerPlateBodyDef.position.Set((self.position.x + width * 0.5) / PTM_RATIO, (self.position.y) / PTM_RATIO);

    b2PolygonShape triggerPlateShape;
    triggerPlateShape.SetAsBox(1/ PTM_RATIO, 1 /PTM_RATIO);

    b2FixtureDef triggerPlateFixtureDef;
    triggerPlateFixtureDef.shape = &triggerPlateShape;

    triggerPlateBody = [[[GameContext sharedContext] currentLevel] initBody:&triggerPlateBodyDef];

    triggerPlateFixture = triggerPlateBody->CreateFixture(&triggerPlateFixtureDef);

    b2Filter filter;
    filter.categoryBits = 0;
    filter.maskBits = 0;

    triggerPlateFixture->SetFilterData(filter);

    b2BodyDef buttonPlateBodyDef;
    buttonPlateBodyDef.type = b2_dynamicBody;
    buttonPlateBodyDef.fixedRotation = true;
    buttonPlateBodyDef.position.Set((self.position.x + width * 0.5) / PTM_RATIO, (self.position.y + height *0.5) / PTM_RATIO);

    b2PolygonShape buttonShape;
    buttonShape.SetAsBox(width / PTM_RATIO, height / 5.0 / PTM_RATIO);

    b2FixtureDef buttonFixtureDef;
    buttonFixtureDef.density = density;
    buttonFixtureDef.friction = 0.2f;
    buttonFixtureDef.shape = &buttonShape;
    buttonFixtureDef.userData = (__bridge void *) self;

    body = [[[GameContext sharedContext] currentLevel] initBody:&buttonPlateBodyDef];

    fixture = body->CreateFixture(&buttonFixtureDef);

    b2Vec2 vec2;
    vec2.x = 0;
    vec2.y = 1;

    b2PrismaticJointDef jointDef;
    jointDef.Initialize(triggerPlateBody, body, triggerPlateBody->GetLocalCenter(), vec2);
    jointDef.lowerTranslation = 0.3;
    jointDef.localAnchorA = triggerPlateBody->GetLocalCenter();
    jointDef.localAnchorB = body->GetLocalCenter();
    jointDef.upperTranslation = 0.8f;
    jointDef.enableLimit = true;
    jointDef.maxMotorForce = 100;
    jointDef.motorSpeed = 4.0f;
    jointDef.enableMotor = true;

    triggerJoint = (b2PrismaticJoint *) [[[GameContext sharedContext] currentLevel] initJoint:&jointDef];

    [super spawn];
}

- (void)update:(ccTime)delta
{
    [super update:delta];

    bool atLowerLimit = triggerJoint->GetJointTranslation() <= triggerJoint->GetLowerLimit();
    bool atUpperLimit = triggerJoint->GetJointTranslation() >= triggerJoint->GetUpperLimit();
    
    if (atLowerLimit && !isTriggered) {
        [trigger doTrigger];
        isTriggered = true;
    }

    if (atUpperLimit && isTriggered) {
        [trigger undoTrigger];
        isTriggered = false;
    }

}


@end
