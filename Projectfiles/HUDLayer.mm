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
#import "Domain/PrimaryColourDimension.h"


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

        // Note : I'm using the position of this dpad to build the overflow touch boxes
        // If you update dpad's anchor point make sure to update that logic.
        dpad = [CCSprite spriteWithSpriteFrameName:@"button_dpad.png"];
        dpad.position = CGPointMake(screenSize.width * 0.11, screenSize.height * 0.09);
        [self addChild:dpad];

        jump = [CCSprite spriteWithSpriteFrameName:@"button_jump.png"];
        jump.position = CGPointMake(screenSize.width * 0.92, screenSize.height * 0.09);
        [self addChild:jump];

        menu = [CCSprite spriteWithSpriteFrameName:@"button_menu.png"];
        menu.position = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.09);
        [self addChild:menu];

        // Add sliding bands
        topband = [CCSprite spriteWithSpriteFrameName:@"band.png"];
        topband.position = CGPointMake(topband.contentSize.height / 2, screenSize.height - topband.contentSize.width / 2);
        topband.rotation = -90;
        [self addChild:topband];

        leftband = [CCSprite spriteWithSpriteFrameName:@"band.png"];
        leftband.position = CGPointMake(leftband.contentSize.width / 2, leftband.contentSize.height / 2);
        leftband.rotation = 180;
        [self addChild:leftband];

        rightband = [CCSprite spriteWithSpriteFrameName:@"band.png"];
        rightband.position = CGPointMake(screenSize.width - rightband.contentSize.width / 2, rightband.contentSize.height / 2);
        [self addChild:rightband];

        // Set sliding transition time
        dimensionTransition = [NSDate date];
        dimensionTransitionDuration = 0.5;

        // Enable touch and updating
        self.isTouchEnabled = YES;

        [self scheduleUpdate];
    }

    return self;

}

- (void)update:(ccTime)delta {

    Player *player = [[[GameContext sharedContext] currentLevel] player];

    KKInput *input = [KKInput sharedInput];
    input.gestureSwipeEnabled = YES;

    // Detect swipe for colour slide, ensure enough time has passed between slides
    if (input.gestureSwipeRecognizedThisFrame && fabs([dimensionTransition timeIntervalSinceNow]) > dimensionTransitionDuration) {
        KKSwipeGestureDirection dir = input.gestureSwipeDirection;
        switch (dir) {
            case KKSwipeGestureDirectionLeft:
                dimensionTransition = [NSDate date];
                if ([[[[[GameContext sharedContext] currentLevel] dimension] colour] isEqualToString:@"red"]) {
                    [[[GameContext sharedContext] currentLevel] setDimension:[[[[GameContext sharedContext] currentLevel] gameWorldLayer] yellowDimension]];
                }
                else if ([[[[[GameContext sharedContext] currentLevel] dimension] colour] isEqualToString:@"yellow"]) {
                    [[[GameContext sharedContext] currentLevel] setDimension:[[[[GameContext sharedContext] currentLevel] gameWorldLayer] blueDimension]];
                }
                else {
                    [[[GameContext sharedContext] currentLevel] setDimension:([[[[GameContext sharedContext] currentLevel] gameWorldLayer] redDimension])];
                }
                break;
            case KKSwipeGestureDirectionRight:
                dimensionTransition = [NSDate date];
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
    if ([input isAnyTouchOnNode:dpad touchPhase:KKTouchPhaseAny]) {

        CGPoint vector = [dpad convertToNodeSpaceAR:[input locationOfAnyTouchInPhase:KKTouchPhaseAny]];

        // we're grabbing a the jump touch location. I'm not sure how to get the correct one.
        // Most likely we'll have to use CGRects or something
        if (vector.x < [[CCDirector sharedDirector] screenCenter].x) {

            if ([player isOnGround]) {
                if (vector.x < 0) {
                    [player moveInDirection:ccp(-1, 0)];
                } else if (vector.x > 0) {
                    [player moveInDirection:ccp(1, 0)];
                }
            }
            else {
                if (vector.x < 0) {
                    [player moveInDirection:ccp(-0.25, 0)];
                } else if (vector.x > 0) {
                    [player moveInDirection:ccp(0.25, 0)];
                }
            }

        }
    } else if ([player isOnGround]) {
        [player frictionizeMotion];
    }

    if ([player isOnGround]) {
        if ([input isAnyTouchOnNode:jump touchPhase:KKTouchPhaseBegan]) {
            [player jump];
        }

    }
}

- (void)slideToColour:(NSString *)colour {

    if ([colour isEqualToString:@"red"]) {
        [topband setColor:(ccc3(255, 0, 0))];
        [leftband setColor:(ccc3(0, 0, 255))];
        [rightband setColor:(ccc3(255, 255, 0))];
    }
    else if ([colour isEqualToString:@"yellow"]) {
        [topband setColor:(ccc3(255, 255, 0))];
        [leftband setColor:(ccc3(255, 0, 0))];
        [rightband setColor:(ccc3(0, 0, 255))];
    }
    else {
        [topband setColor:(ccc3(0, 0, 255))];
        [leftband setColor:(ccc3(255, 255, 0))];
        [rightband setColor:(ccc3(255, 0, 0))];
    }
}


@end