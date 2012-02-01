//
//  Ball.m
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Ball.h"
#import "GameContext.h"
#import "Level.h"

@implementation Ball


- (id)initWithRadius:(float32)aRadius height:(float32)aHeight width:(float32)aWidth {
    self = [super init];
    if (self) {
        radius = aRadius;
        height = aHeight;
        width = aWidth;
    }

    return self;
}

- (void)spawn {

    sprite = [CCSprite spriteWithFile:@"test_crate_sprite.png"];

    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(self.position.x / PTM_RATIO, self.position.y / PTM_RATIO);
    bodyDef.bullet = true;

    bodyDef.userData = (__bridge void *) sprite;

    body = [[[GameContext sharedContext] currentLevel] initBody:&bodyDef];

    b2CircleShape collisionShape;
    collisionShape.m_p.Set(width / PTM_RATIO * 0.5, height / PTM_RATIO * 0.5);
    collisionShape.m_radius = radius;

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
