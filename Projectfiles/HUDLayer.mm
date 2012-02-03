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


@implementation HUDLayer
{

}

- (id)init
{
    self = [super init];
    if (self) {
        // Get dimensions
        CGSize screenSize = [[CCDirector sharedDirector] winSize];

        // Add screen buttons
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"hud.plist"];

        // Note : I'm using the position of this dpad to build the overflow touch boxes
        // If you update dpad's anchor point make sure to update that logic.
        dpad = [CCSprite spriteWithSpriteFrameName:@"button_dpad.png"];
        dpad.position = CGPointMake(screenSize.width * 0.11, screenSize.height * 0.09);
        [self addChild:dpad z:1];

        jump = [CCSprite spriteWithSpriteFrameName:@"button_jump.png"];
        jump.position = CGPointMake(screenSize.width * 0.92, screenSize.height * 0.09);
        [self addChild:jump z:1];

        menu = [CCSprite spriteWithSpriteFrameName:@"button_menu.png"];
        menu.position = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.09);
        [self addChild:menu z:1];

        // Add sliding bands
        topband = [CCSprite spriteWithSpriteFrameName:@"band.png"];
        topband.position = CGPointMake(topband.contentSize.height / 2, screenSize.height - topband.contentSize.width / 2);
        topband.rotation = -90;
        [self addChild:topband];
        topbandFx = [CCParticleSystemQuad particleWithFile:@"band.plist"]; 
        topbandFx.position = CGPointMake(topband.contentSize.height / 2, 10 + screenSize.height - topband.contentSize.width / 2);
        topbandFx.rotation = -90;
        [self addChild:topbandFx]; 

        leftband = [CCSprite spriteWithSpriteFrameName:@"band.png"];
        leftband.position = CGPointMake(leftband.contentSize.width / 2, leftband.contentSize.height / 2);
        leftband.rotation = 180;
        [self addChild:leftband];
        leftbandFx = [CCParticleSystemQuad particleWithFile:@"band.plist"]; 
        leftbandFx.position = CGPointMake(leftband.contentSize.width / 2 - 10, leftband.contentSize.height / 2);
        leftbandFx.rotation = 180;
        [self addChild:leftbandFx]; 

        rightband = [CCSprite spriteWithSpriteFrameName:@"band.png"];
        rightband.position = CGPointMake(screenSize.width - rightband.contentSize.width / 2, rightband.contentSize.height / 2);
        [self addChild:rightband];
        rightbandFx = [CCParticleSystemQuad particleWithFile:@"band.plist"]; 
        rightbandFx.position = CGPointMake(10 + screenSize.width - rightband.contentSize.width / 2, rightband.contentSize.height / 2);
        [self addChild:rightbandFx]; 
        
        // Add slide effect
        leftSlide = [CCParticleSystemQuad particleWithFile:@"slide.plist"]; 
        leftSlide.position = CGPointMake(leftband.contentSize.width / 2, screenSize.height / 2);
        leftSlide.rotation = 180;
        [self addChild:leftSlide]; 
        
        rightSlide = [CCParticleSystemQuad particleWithFile:@"slide.plist"]; 
        rightSlide.position = CGPointMake(screenSize.width - rightband.contentSize.width / 2, screenSize.height / 2);
        [self addChild:rightSlide]; 

        // Set sliding transition time
        dimensionTransition = [NSDate date];
        dimensionTransitionDelay = 0.225;
        dimensionTransitionDuration = 0.5;

        // Enable touch and updating
        self.isTouchEnabled = YES;

        [self scheduleUpdate];
    }

    return self;

}

- (void)update:(ccTime)delta
{
    
    CCArray* touches = [KKInput sharedInput].touches;
    KKTouch* touch;
    CCARRAY_FOREACH(touches, touch)
    {
        NSLog(@"Touch: %u", touch.touchID);
    }

    Player *player = [[[GameContext sharedContext] currentLevel] player];

    KKInput *input = [KKInput sharedInput];
    input.gestureSwipeEnabled = YES;

    // Detect swipe for colour slide, ensure enough time has passed between slides
    if (input.gestureSwipeRecognizedThisFrame && fabs([dimensionTransition timeIntervalSinceNow]) > dimensionTransitionDuration) {
        KKSwipeGestureDirection dir = input.gestureSwipeDirection;
        if (dir == KKSwipeGestureDirectionLeft || dir == KKSwipeGestureDirectionRight)
        {
            // Start slide
            dimensionTransition = [NSDate date];

            if (dir == KKSwipeGestureDirectionLeft)
            {
                if ([[[[[GameContext sharedContext] currentLevel] dimension] colour] isEqualToString:@"red"]) {
                    dimensionSlidingTo = [[[[GameContext sharedContext] currentLevel] gameWorldLayer] yellowDimension];
                    [rightSlide setStartColor:(ccc4f(1, 1, 0, 0.32))];
                    [rightSlide setEndColor:(ccc4f(1, 1, 0, 0))];
                }
                else if ([[[[[GameContext sharedContext] currentLevel] dimension] colour] isEqualToString:@"yellow"]) {
                    dimensionSlidingTo = [[[[GameContext sharedContext] currentLevel] gameWorldLayer] blueDimension];
                    [rightSlide setStartColor:(ccc4f(0, 0, 1, 0.32))];
                    [rightSlide setEndColor:(ccc4f(0, 0, 1, 0))];
                }
                else {
                    dimensionSlidingTo = [[[[GameContext sharedContext] currentLevel] gameWorldLayer] redDimension];
                    [rightSlide setStartColor:(ccc4f(1, 0, 0, 0.32))];
                    [rightSlide setEndColor:(ccc4f(1, 0, 0, 0))];
                }
                [rightSlide resetSystem];
            }
            else
            {
                dimensionTransition = [NSDate date];
                if ([[[[[GameContext sharedContext] currentLevel] dimension] colour] isEqualToString:@"red"]) {
                    dimensionSlidingTo = [[[[GameContext sharedContext] currentLevel] gameWorldLayer] blueDimension];
                    [leftSlide setStartColor:(ccc4f(0, 0, 1, 0.32))];
                    [leftSlide setEndColor:(ccc4f(0, 0, 1, 0))];
                }
                else if ([[[[[GameContext sharedContext] currentLevel] dimension] colour] isEqualToString:@"yellow"]) {
                    dimensionSlidingTo = [[[[GameContext sharedContext] currentLevel] gameWorldLayer] redDimension];
                    [leftSlide setStartColor:(ccc4f(1, 0, 0, 0.32))];
                    [leftSlide setEndColor:(ccc4f(1, 0, 0, 0))];
                }
                else {
                    dimensionSlidingTo = [[[[GameContext sharedContext] currentLevel] gameWorldLayer] yellowDimension];
                    [leftSlide setStartColor:(ccc4f(1, 1, 0, 0.32))];
                    [leftSlide setEndColor:(ccc4f(1, 1, 0, 0))];
                }
                [leftSlide resetSystem];
            }
        }
    }
    
    // Midway through slide, change colours
    if (dimensionSlidingTo != NULL && fabs([dimensionTransition timeIntervalSinceNow]) > dimensionTransitionDelay) {
        [[[GameContext sharedContext] currentLevel] setDimension:dimensionSlidingTo];
        dimensionSlidingTo = NULL;  
    }

    // D-Pad
    if ([input isAnyTouchOnNode:dpad touchPhase:KKTouchPhaseAny]) {

        CGPoint vector = [dpad convertToNodeSpaceAR:[input locationOfAnyTouchInPhase:KKTouchPhaseAny]];

        // we're grabbing a the jump touch location. I'm not sure how to get the correct one.
        // Most likely we'll have to use CGRects or something
        if (vector.x < [[CCDirector sharedDirector] screenCenter].x) {

            if (vector.x < 0) {
                [dpad setDisplayFrame:[frameCache spriteFrameByName:@"button_dpad_pushed_left.png"]];
                // Player can't jump or move in mid air
                if ([player isOnGround]) {
                    [player moveInDirection:ccp(-1, 0)];
                }
                else {
                    [player moveInDirectionWhileInAir:ccp(-1, 0)];
                }
                
            }
            else {
                [dpad setDisplayFrame:[frameCache spriteFrameByName:@"button_dpad_pushed_right.png"]];
                if ([player isOnGround]) {
                    [player moveInDirection:ccp(1, 0)];
                }
                else {
                
                    [player moveInDirectionWhileInAir:ccp(1, 0)];
                }
            }
        }
    } else {
        [dpad setDisplayFrame:[frameCache spriteFrameByName:@"button_dpad.png"]];
        if ([player isOnGround]) {
            [player frictionizeMotion];
        }
    }

    // Jump button
    if ([input isAnyTouchOnNode:jump touchPhase:KKTouchPhaseAny]) {
        [jump setDisplayFrame:[frameCache spriteFrameByName:@"button_jump_pushed.png"]];
        if ([player isOnGround] && [input isAnyTouchOnNode:jump touchPhase:KKTouchPhaseBegan]) {
            [player jump];
        }
    }
    else {
        [jump setDisplayFrame:[frameCache spriteFrameByName:@"button_jump.png"]];
    }
    
    // Pause button
    if ([input isAnyTouchOnNode:menu touchPhase:KKTouchPhaseAny]) {
        [menu setDisplayFrame:[frameCache spriteFrameByName:@"button_menu_pushed.png"]];
    }
    else {
        [menu setDisplayFrame:[frameCache spriteFrameByName:@"button_menu.png"]];
    }
}

- (void)slideToColour:(NSString *)colour
{
    if ([colour isEqualToString:@"red"]) {
        [topband setColor:(ccc3(255, 0, 0))];
        [topbandFx setStartColor:(ccc4f(1, 0, 0, 0.2))];
        [topbandFx setEndColor:(ccc4f(1, 0, 0, 0.1))];
        
        [leftband setColor:(ccc3(0, 0, 255))];
        [leftbandFx setStartColor:(ccc4f(0, 0, 1, 0.2))];
        [leftbandFx setEndColor:(ccc4f(0, 0, 1, 0.1))];
        
        [rightband setColor:(ccc3(255, 255, 0))];
        [rightbandFx setStartColor:(ccc4f(1, 1, 0, 0.2))];
        [rightbandFx setEndColor:(ccc4f(1, 1, 0, 0.1))];
    }
    else if ([colour isEqualToString:@"yellow"]) {
        [topband setColor:(ccc3(255, 255, 0))];
        [topbandFx setStartColor:(ccc4f(1, 1, 0, 0.2))];
        [topbandFx setEndColor:(ccc4f(1, 1, 0, 0.1))];
        
        [leftband setColor:(ccc3(255, 0, 0))];
        [leftbandFx setStartColor:(ccc4f(1, 0, 0, 0.2))];
        [leftbandFx setEndColor:(ccc4f(1, 0, 0, 0.1))];
        
        [rightband setColor:(ccc3(0, 0, 255))];
        [rightbandFx setStartColor:(ccc4f(0, 0, 1, 0.2))];
        [rightbandFx setEndColor:(ccc4f(0, 0, 1, 0.1))];
    }
    else {
        [topband setColor:(ccc3(0, 0, 255))];
        [topbandFx setStartColor:(ccc4f(0, 0, 1, 0.2))];
        [topbandFx setEndColor:(ccc4f(0, 0, 1, 0.1))];
        
        [leftband setColor:(ccc3(255, 255, 0))];
        [leftbandFx setStartColor:(ccc4f(1, 1, 0, 0.2))];
        [leftbandFx setEndColor:(ccc4f(1, 1, 0, 0.1))];
        
        [rightband setColor:(ccc3(255, 0, 0))];
        [rightbandFx setStartColor:(ccc4f(1, 0, 0, 0.2))];
        [rightbandFx setEndColor:(ccc4f(1, 0, 0, 0.1))];
    }
}


@end