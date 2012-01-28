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
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache]; 
        [frameCache addSpriteFramesWithFile:@"buttons.plist"]; 
        
        // Get dimensions
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        dpad = [CCSprite spriteWithSpriteFrameName:@"button_dpad.png"];
        dpad.position = CGPointMake(screenSize.width*0.1, screenSize.height*0.1);
        
        jump = [CCSprite spriteWithSpriteFrameName:@"button_jump.png"];
        jump.position = CGPointMake(screenSize.width*0.9, screenSize.height*0.1);
    }

    return self;

}

-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event 
{
    CGPoint touchPoint = [self convertTouchToNodeSpace: touch];
    float dpadDistance = sqrt((touchPoint.x - dpad.position.x)*(touchPoint.x - dpad.position.x) + (touchPoint.y - dpad.position.y)*(touchPoint.y - dpad.position.y));
    if (dpadDistance < 100 && dpadDistance > 10)
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
    
    return true;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event 
{
    CGPoint touchPoint = [self convertTouchToNodeSpace: touch];
    float dpadDistance = sqrt((touchPoint.x - dpad.position.x)*(touchPoint.x - dpad.position.x) + (touchPoint.y - dpad.position.y)*(touchPoint.y - dpad.position.y));
    if (dpadDistance < 100 && dpadDistance > 10)
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




- (void)tick:(float)delta {

}

- (void)update:(ccTime)delta {

    Player *player = [[[GameContext sharedContext] currentLevel] player];

    if (direction < 0)
    {
        [player moveInDirection:(CGPointMake(-1,0))];
    }
    else if (direction > 0)
    {
        [player moveInDirection:(CGPointMake(1,0))];
    }
    else
    {
        [player stopXMovement];
    }
}


@end