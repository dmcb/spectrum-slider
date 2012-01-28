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
        float stickRadius = 50.0;
         
        joystick = [SneakyJoystick joystickWithRect:CGRectMake(100, 100, stickRadius, stickRadius)];
         
        joystick.deadRadius = 5;
         
        joystick.hasDeadzone = YES;
         
        skinnedJoystick = [SneakyJoystickSkinnedBase skinnedJoystick];
         
        skinnedJoystick.position = CGPointMake(stickRadius * 1.5f, stickRadius * 1.5f);
         
        skinnedJoystick.backgroundSprite = [CCSprite spriteWithFile:@"JoystickButton.png"];
         
        skinnedJoystick.thumbSprite = [CCSprite spriteWithFile:@"shittyDPad.png"];
         
        skinnedJoystick.joystick = joystick;
         
        [self addChild:skinnedJoystick z:1];

    }

    return self;

}

-(void)tick:(float)delta {

}

- (void)update:(ccTime)delta {
    CGPoint velocity = ccpMult(joystick.velocity, 100);

    Player *player = [[[GameContext sharedContext] currentLevel] player];

    if (velocity.x != 0 && velocity.y != 0) {

        //null out the vertical velocity
        velocity.y = 0;

        [player moveInDirection:velocity];
    } else {
        [player stopXMovement];
    }
}


@end