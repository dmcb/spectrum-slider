//
//  Door.m
//  Spectrum-Slider
//

#import "Door.h"
#import "GameContext.h"
#import "Level.h"

@implementation Door

- (id)initWithHeight:(float32)aHeight width:(float32)aWidth closeIfNotTriggered:(bool)aCloseIfNotTriggered
{
    self = [super init];
    if (self) {
        height = aHeight;
        width = aWidth;
        closeIfNotTriggered = aCloseIfNotTriggered;
    }

    return self;
}

- (void)spawn
{
    sprite = [CCSprite spriteWithFile:@"test_crappy_door_sprite.png"];

    [sprite setScaleX:width / sprite.contentSize.width];
    [sprite setScaleY:height / sprite.contentSize.height];

    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set((self.position.x + width * 0.5) / PTM_RATIO, (self.position.y + height * 0.5) / PTM_RATIO);

    bodyDef.userData = (__bridge void *) sprite;

    body = [[[GameContext sharedContext] currentLevel] initBody:&bodyDef];

    b2PolygonShape collisionShape;
    collisionShape.SetAsBox(width / PTM_RATIO * 0.5, height / PTM_RATIO * 0.5);
    // todo make these parameters. (density and such)

    b2FixtureDef shapeDef;
    shapeDef.shape = &collisionShape;
    shapeDef.density = 1000.0f;
    shapeDef.restitution = 0.0f;
    shapeDef.userData = (__bridge void *) sprite;

    fixture = body->CreateFixture(&shapeDef);

    [super spawn];
}

- (void)doAction
{
    CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:2.0f];

    [sprite runAction:fadeOut];

    b2Filter filter;

    filter.maskBits = 0x0;
    filter.groupIndex = 0x0;
    filter.categoryBits = 0x0;

    fixture->SetFilterData(filter);
}

- (void)undoAction
{
    if (closeIfNotTriggered) {
        CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:2.0f];

        [sprite runAction:fadeIn];

        [self setCollisionGroupId:cid];
    }
}


@end
