//
//  Crate.m
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Crate.h"
#import "GameContext.h"
#import "Level.h"

@implementation Crate


- (id)initWithHeight:(float32)aHeight width:(float32)aWidth
{
    self = [super init];
    if (self) {
        height = aHeight;
        width = aWidth;
    }

    return self;
//To change the template use AppCode | Preferences | File Templates.
}

- (void)spawn
{
    sprite = [CCSprite spriteWithFile:@"test_crate_sprite.png"];

    [sprite setScaleX:width / sprite.contentSize.width];
    [sprite setScaleY:height / sprite.contentSize.height];

    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(self.position.x / PTM_RATIO, self.position.y / PTM_RATIO);
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

    fixture->SetFriction(0.1f);

    [super spawn];
}
@end
