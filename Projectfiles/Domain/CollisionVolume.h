//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Updateable.h"

@interface CollisionVolume : NSObject <Updateable> {

    CCNode *gameObject;

    __unsafe_unretained struct b2Body *body;
    __unsafe_unretained struct b2Fixture *fixture;

}
- (id)initWithGameObject:(CCNode *)aGameObject collisionGroupId:(int)collisionId width:(float)width height:(float)height;

@end