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
    //create an instance of the SneakyJoystick class
   SneakyJoystick* joystick;

   //create an instance of the SneakyJoystickSkinnedBase class
   SneakyJoystickSkinnedBase* skinnedJoystick;
}
@end