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

@implementation Button

- (id)initWithTrigger:(NSString *)aTrigger width:(float32)aWidth height:(float32)aHeight
{
    self = [super init];
    if (self) {
        trigger = aTrigger;
        width = aWidth;
        height = aHeight;
    }

    return self;
}

- (void)spawn
{
    sprite = [CCSprite spriteWithFile:@"test_crappy_button_sprite.png"];

    [sprite setScaleX:width / sprite.contentSize.width];
    [sprite setScaleY:height / sprite.contentSize.height];

    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set((self.position.x + width * 0.5) / PTM_RATIO, (self.position.y + height * 0.5) / PTM_RATIO);
    bodyDef.bullet = true;

    bodyDef.userData = (__bridge void *) self;

    body = [[[GameContext sharedContext] currentLevel] initBody:&bodyDef];

    b2PolygonShape collisionShape;
    collisionShape.SetAsBox(width / PTM_RATIO * 0.5, height / PTM_RATIO * 0.5);
    // todo make these parameters. (density and such)

    b2FixtureDef shapeDef;
    shapeDef.shape = &collisionShape;
    shapeDef.density = 2.0f;
    shapeDef.restitution = 0.0f;
    shapeDef.userData = (__bridge void *) self;
    shapeDef.isSensor = true;

    fixture = body->CreateFixture(&shapeDef);

    [super spawn];
}

- (void) performTrigger
{
    [[NSNotificationCenter defaultCenter] postNotificationName:trigger object:nil];
}


@end