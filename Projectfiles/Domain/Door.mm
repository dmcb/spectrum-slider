//
//  Door.m
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Door.h"
#import "GameContext.h"
#import "Level.h"

@implementation Door

- (id)initWithHeight:(float32)aHeight width:(float32)aWidth triggerName:(NSString *)aTriggerName
{
    self = [super initWithTriggerName:aTriggerName];
    if (self) {
        height = aHeight;
        width = aWidth;
    }

    return self;
}

- (void)spawn
{
    sprite = [CCSprite spriteWithFile:@"test_crappy_door_sprite.png"];

    [sprite setScaleX:width / sprite.contentSize.width];
    [sprite setScaleY:height / sprite.contentSize.height];

    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set((self.position.x + width *0.5) / PTM_RATIO, (self.position.y + height *0.5) / PTM_RATIO);
    bodyDef.bullet = true;

    bodyDef.userData = (__bridge void *) sprite;

    body = [[[GameContext sharedContext] currentLevel] initBody:&bodyDef];

    b2PolygonShape collisionShape;
    collisionShape.SetAsBox(width / PTM_RATIO * 0.5, height / PTM_RATIO * 0.5);
    // todo make these parameters. (density and such)

    b2FixtureDef shapeDef;
    shapeDef.shape = &collisionShape;
    shapeDef.density = 2.0f;
    shapeDef.restitution = 0.0f;
    shapeDef.userData = (__bridge void *) sprite;

    fixture = body->CreateFixture(&shapeDef);

    [super spawn];
}

- (void) trigger
{
    // todo
    CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:2.0f];

    [sprite runAction:fadeOut];

    b2Filter filter = fixture->GetFilterData();

    filter.categoryBits = 0;
    filter.maskBits = 0;
}



@end
