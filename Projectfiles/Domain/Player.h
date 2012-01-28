//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Updateable.h"

@class PlayerActionContext;
@class CollisionVolume;


@interface Player : CCNode <Updateable> {
    PlayerActionContext *actionContext;
    CollisionVolume *collisionVolume;
    CCSprite *sprite;
}

@end