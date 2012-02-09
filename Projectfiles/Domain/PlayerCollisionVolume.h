//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Updateable.h"

@class HeadSensor;

@interface PlayerCollisionVolume : NSObject <Updateable> {

    CCNode *gameObject;

    b2Body *body;
    b2Fixture *fixture;

    HeadSensor *headSensor;
}
@property(nonatomic, assign) b2Body *body;
@property(nonatomic, assign) b2Fixture *fixture;


- (id)initWithGameObject:(CCNode *)aGameObject collisionGroupId:(int)collisionId width:(float)width height:(float)height;

- (void)setCollisionGroupId:(uint16)newCollisionGroup;

- (bool) isHeadCollidingWithAnything;

@end