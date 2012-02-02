//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
#import "ColoredCircleSprite.h"
#import "Updateable.h"

@interface HUDLayer : CCLayer <Updateable> {
    CCSprite *dpad;
    CCSprite *jump;
    CCSprite *menu;
    
    CCSprite *topband;
    CCSprite *leftband;
    CCSprite *rightband;
    
    CCParticleSystem *topbandFx;
    CCParticleSystem *leftbandFx;
    CCParticleSystem *rightbandFx;
    
    int direction;
    
    NSDate *dimensionTransition;
    double dimensionTransitionDuration;
}

- (void)slideToColour:(NSString *)colour;

@end