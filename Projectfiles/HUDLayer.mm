//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "HUDLayer.h"
#import "GameContext.h"
#import "Level.h"
#import "Player.h"
#import "GameWorldLayer.h"
#import "ColorDimension.h"


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
        menu.position = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.08);
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

    NSLog(@"Current colour: %s",[[[[GameContext sharedContext] currentLevel] dimension] colour]);
    Player *player = [[[GameContext sharedContext] currentLevel] player];

    KKInput *input = [KKInput sharedInput];
    input.gestureSwipeEnabled = YES;
    
    // Detect swipe for colour slide
    if (input.gestureSwipeRecognizedThisFrame) {
        KKSwipeGestureDirection dir = input.gestureSwipeDirection;
        switch (dir)
        {
            case KKSwipeGestureDirectionRight:
                if ([[[[[GameContext sharedContext] currentLevel] dimension] colour] isEqualToString:@"red"]) {
                    [[[GameContext sharedContext] currentLevel] setDimension:[[[[GameContext sharedContext] currentLevel] gameWorldLayer] yellowDimension]];
                }
                else if ([[[[[GameContext sharedContext] currentLevel] dimension] colour] isEqualToString:@"yellow"]) {
                    [[[GameContext sharedContext] currentLevel] setDimension:[[[[GameContext sharedContext] currentLevel] gameWorldLayer] blueDimension]];
                }
                else  {
                    [[[GameContext sharedContext] currentLevel] setDimension:([[[[GameContext sharedContext] currentLevel] gameWorldLayer] redDimension])];
                }
                break;
            case KKSwipeGestureDirectionLeft:
                if ([[[[[GameContext sharedContext] currentLevel] dimension] colour] isEqualToString:@"red"]) {
                    [[[GameContext sharedContext] currentLevel] setDimension:[[[[GameContext sharedContext] currentLevel] gameWorldLayer] blueDimension]];
                }
                else if ([[[[[GameContext sharedContext] currentLevel] dimension] colour] isEqualToString:@"yellow"]) {
                    [[[GameContext sharedContext] currentLevel] setDimension:[[[[GameContext sharedContext] currentLevel] gameWorldLayer] redDimension]];
                }
                else {
                    [[[GameContext sharedContext] currentLevel] setDimension:([[[[GameContext sharedContext] currentLevel] gameWorldLayer] yellowDimension])];
                }
                break;
            case KKSwipeGestureDirectionUp:
                // direction-specific code here
                break;
            case KKSwipeGestureDirectionDown:
                // direction-specific code here
                break;
        }
    }

    // Player can't jump or move in mid air
    if ([player isOnGround]) {
        if ([input isAnyTouchOnNode:dpad touchPhase:KKTouchPhaseAny]) {
            CGPoint vector;

            CGPoint location = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];

            vector = ccpSub(location, [dpad position]);

            if (vector.x < 0) {
                [player moveInDirection:ccp(-1, 0)];
            } else if (vector.x > 0) {
                [player moveInDirection:ccp(1, 0)];
            }
        } else {
            [player frictionizeMotion];
        }

        if ([input isAnyTouchOnNode:jump touchPhase:KKTouchPhaseBegan]) {
            [player jump];
        }

    }
}

- (void)slideToColour:(NSString *)colour {

    if ([colour isEqualToString:@"red"])
    {
        [leftband setColor:(ccc3(0,0,255))];
        [rightband setColor:(ccc3(255,255,0))];
    }
    else if ([colour isEqualToString:@"yellow"])
    {
        [leftband setColor:(ccc3(255,0,0))];
        [rightband setColor:(ccc3(0,0,255))];        
    }
    else
    {
        [leftband setColor:(ccc3(255,255,0))];
        [rightband setColor:(ccc3(255,0,0))];
    }
}


@end