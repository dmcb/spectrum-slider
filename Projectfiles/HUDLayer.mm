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
    Player *player = [[[GameContext sharedContext] currentLevel] player];
    
    CCArray* touches = [KKInput sharedInput].touches;
    KKTouch* touch;
    
    bool dpadSatisfied = false;
    bool jumpSatisfied = false;
    
    //NSLog(@"Dpad touch: %u. Jump touch: %u.", touchDpad, touchJump);
    
    // Keep track of all touches, and remember what touches are on what buttons
    CCARRAY_FOREACH(touches, touch)
    {
        if ((touchDpad == 0 || touchDpad == touch.touchID) &&
                sqrt((touch.location.x - dpad.position.x)*(touch.location.x - dpad.position.x) + (touch.location.y - dpad.position.y)*(touch.location.y - dpad.position.y)) < 
                    dpad.contentSize.width * 0.7)
        {
            // Dpad button has just started - or continues to be - touched
            dpadSatisfied = true;
            
            // If this is a new dpad press, assign the touch id to the dpad button
            if (touchDpad == 0) {
                touchDpad = touch.touchID;
            }
            
            // Determine movement direction
            if (touch.location.x - dpad.position.x < 0) {
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
            
            // Remove touch so it can't be considered for swiping
            //[[KKInput sharedInput] removeTouch:touch];
        }
        if ((touchJump == 0 || touchJump == touch.touchID) &&
                 sqrt((touch.location.x - jump.position.x)*(touch.location.x - jump.position.x) + (touch.location.y - jump.position.y)*(touch.location.y - jump.position.y)) < 
                    jump.contentSize.width * 0.7)
        {
            // Jump button has just started - or continues to be - touched
            jumpSatisfied = true;
            
            // If this is a new jump, start the jump and assign the touch id to the jump button
            if (touchJump == 0) {
                touchJump = touch.touchID;
                [jump setDisplayFrame:[frameCache spriteFrameByName:@"button_jump_pushed.png"]];
                if ([player isOnGround]) {
                    [player jump];
                }
            }
                
            // Remove touch so it can't be considered for swiping
            //[[KKInput sharedInput] removeTouch:touch];
        }
    }
    
    // If buttons that used to be pressed are no longer, unpress them
    if (touchDpad != 0 && !dpadSatisfied)
    {
        touchDpad = 0;
        [dpad setDisplayFrame:[frameCache spriteFrameByName:@"button_dpad.png"]];
        if ([player isOnGround]) {
            [player frictionizeMotion];
        }
    }
    if (touchJump != 0 && !jumpSatisfied)
    {
        touchJump = 0;
        [jump setDisplayFrame:[frameCache spriteFrameByName:@"button_jump.png"]];
    }

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