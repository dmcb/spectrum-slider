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
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache]; 
        [frameCache addSpriteFramesWithFile:@"hud.plist"]; 
        
        dpad = [CCSprite spriteWithSpriteFrameName:@"button_dpad.png"];
        dpad.position = CGPointMake(screenSize.width*0.08, screenSize.height*0.08);
        [self addChild:dpad];
        
        jump = [CCSprite spriteWithSpriteFrameName:@"button_jump.png"];
        jump.position = CGPointMake(screenSize.width*0.94, screenSize.height*0.08);
        [self addChild:jump];
        
        menu = [CCSprite spriteWithSpriteFrameName:@"button_menu.png"];
        menu.position = CGPointMake(screenSize.width*0.94, screenSize.height*0.92);
        [self addChild:menu];
        
        // Add sliding bands
        leftband = [CCSprite spriteWithSpriteFrameName:@"leftband.png"];
        leftband.position = CGPointMake(0, 0);
        leftband.anchorPoint = CGPointMake(0, 0);
        [self addChild:leftband];
        
        rightband = [CCSprite spriteWithSpriteFrameName:@"rightband.png"];
        rightband.position = CGPointMake(screenSize.width-rightband.contentSize.width, 0);
        rightband.anchorPoint = CGPointMake(0, 0);
        [self addChild:rightband];
        
        
        
        // Enable touch and updating
        self.isTouchEnabled = YES;
        
        [self scheduleUpdate];
        
        // Manually add this class as receiver of targeted touch events.
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
    }

    return self;

}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event 
{
    CGPoint touchPoint = [self convertTouchToNodeSpace: touch];
    
    // Check if touching dpad
    float dpadDistance = sqrt((touchPoint.x - dpad.position.x)*(touchPoint.x - dpad.position.x) + (touchPoint.y - dpad.position.y)*(touchPoint.y - dpad.position.y));
    // 10 px deadzone
    if (dpadDistance < 80 && dpadDistance > 25)
    {
        if (touchPoint.x - dpad.position.x > 0)
        {
            direction = 1;
        }
        else if (touchPoint.x - dpad.position.x < 0)
        {
            direction = -1;
        }
    }
    else
    {
        direction = 0;
    }
    
    // Check if touching jump
    float jumpDistance = sqrt((touchPoint.x - jump.position.x)*(touchPoint.x - jump.position.x) + (touchPoint.y - jump.position.y)*(touchPoint.y - jump.position.y));
    if (jumpDistance < 80)
    { 
        leap = 1;
    }
    
    return true;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event 
{
    CGPoint touchPoint = [self convertTouchToNodeSpace: touch];
    
    // Check if touching dpad
    float dpadDistance = sqrt((touchPoint.x - dpad.position.x)*(touchPoint.x - dpad.position.x) + (touchPoint.y - dpad.position.y)*(touchPoint.y - dpad.position.y));
    if (dpadDistance < 80 && dpadDistance > 25)
    {
        if (touchPoint.x - dpad.position.x > 0)
        {
            direction = 1;
        }
        else if (touchPoint.x - dpad.position.x < 0)
        {
            direction = -1;
        }
    }
    else
    {
        direction = 0;
    }    
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event 
{
    direction = 0;
}

- (void)update:(ccTime)delta {
    
//    NSLog(@"Direction: %d. Leap: %d", direction, leap);
    
    Player *player = [[[GameContext sharedContext] currentLevel] player];

    if (direction < 0)
    {
        [player moveInDirection:(CGPointMake(-200,0))];
    }
    else if (direction > 0)
    {
        [player moveInDirection:(CGPointMake(200,0))];
    }
    else if (!leap)
    {
        [player stopXMovement];
    }
    
    if (leap)
    {
        [player jump];
        
        leap = 0; // Jump absorbed
    }
}


@end