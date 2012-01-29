//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "HUDLayer.h"
#import "GameContext.h"
#import "Level.h"
#import "Player.h"


@implementation HUDLayer {

}

- (id)init {
    self = [super init];
    if (self) {
        // Get dimensions
        CGSize screenSize = [[CCDirector sharedDirector] winSize];

        // Add screen buttons
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"hud.plist"];

        dpad = [CCSprite spriteWithSpriteFrameName:@"button_dpad.png"];
        dpad.position = CGPointMake(screenSize.width * 0.08, screenSize.height * 0.08);
        [self addChild:dpad];

        jump = [CCSprite spriteWithSpriteFrameName:@"button_jump.png"];
        jump.position = CGPointMake(screenSize.width * 0.94, screenSize.height * 0.08);
        [self addChild:jump];

        menu = [CCSprite spriteWithSpriteFrameName:@"button_menu.png"];
        menu.position = CGPointMake(screenSize.width * 0.94, screenSize.height * 0.92);
        [self addChild:menu];

        // Add sliding bands
        leftband = [CCSprite spriteWithSpriteFrameName:@"leftband.png"];
        leftband.position = CGPointMake(0, 0);
        leftband.anchorPoint = CGPointMake(0, 0);
        [self addChild:leftband];

        rightband = [CCSprite spriteWithSpriteFrameName:@"rightband.png"];
        rightband.position = CGPointMake(screenSize.width - rightband.contentSize.width, 0);
        rightband.anchorPoint = CGPointMake(0, 0);
        [self addChild:rightband];

        // Enable touch and updating
        self.isTouchEnabled = YES;

        [self scheduleUpdate];
    }

    return self;

}

- (void)update:(ccTime)delta {

    Player *player = [[[GameContext sharedContext] currentLevel] player];

    KKInput *input = [KKInput sharedInput];

    if ([player isOnGround]) {
        if ([input isAnyTouchOnNode:dpad touchPhase:KKTouchPhaseAny]) {
            CGPoint vector;

            CGPoint location = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];

            vector = ccpSub(location, [dpad position]);

            if (vector.x < 0) {
                [player moveInDirection:ccp(-200, 0)];
            } else if (vector.x > 0) {
                [player moveInDirection:ccp(200, 0)];
            }
        }

        if ([input isAnyTouchOnNode:jump touchPhase:KKTouchPhaseBegan]) {
            [player jump];
        }
    }
}


@end