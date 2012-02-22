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
#import "Domain/PrimaryColourDimension.h"

@interface HUDLayer : CCLayer <Updateable> {
    CCSpriteFrameCache *frameCache;
    CCSprite *dpad;
    CCSprite *jump;
    CCSprite *menu;
    
    CCSprite *topband;
    CCSprite *leftband;
    CCSprite *rightband;
    
    CCParticleSystem *topbandFx;
    CCParticleSystem *leftbandFx;
    CCParticleSystem *rightbandFx;
    
    CCParticleSystem *leftSlide;
    CCParticleSystem *rightSlide;
    
    int direction;
    
    NSUInteger touchDpad;
    NSUInteger touchJump;
    
    PrimaryColourDimension *dimensionSlidingTo;
    NSDate *dimensionTransition;
    double dimensionTransitionDelay;
    double dimensionTransitionDuration;

    bool ignoreInput;
}

@property (nonatomic) bool ignoreInput;

- (void)slideToColour:(NSString *)colour;

@end