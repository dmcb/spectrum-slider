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
    
    CCSprite *leftband;
    CCSprite *rightband;
    
    int direction;
    int leap;
}
@end