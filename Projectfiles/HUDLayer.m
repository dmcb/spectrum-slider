//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "HUDLayer.h"


@implementation HUDLayer {

}

- (id)init {
    self = [super init];
    if (self) {
        SneakyJoystickSkinnedBase *leftJoy = [[SneakyJoystickSkinnedBase alloc] init];
        leftJoy.position = ccp(64,64);
        // Sprite that will act as the outter circle. Make this the same width as joystick.
        leftJoy.backgroundSprite = [CCSprite spriteWithFile:@"outerJoy.png"];
        // Sprite that will act as the actual Joystick. Definitely make this smaller than outer circle.
        leftJoy.thumbSprite = [CCSprite spriteWithFile:@"innerJoy.png"];
        [self schedule:@selector(tick:)];
    }

    return self;

}

-(void)tick:(float)delta {
///* This will take the joystick and tell a special method (not listed here, outside the scope of this guide) to take the joystick, apply movement to hero (CCSprite or else) and apply the real delta (to avoid uneven or choppy movement, delta is the time since the last time the method was called, in milliseconds). */
//[self applyJoystick:leftJoystick toNode:hero forTimeDelta:delta];
}


@end