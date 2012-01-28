//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Updateable.h"

@interface CollisionVolume : NSObject <Updateable> {

    CCNode *gameObject;

    b2Body *body;
    b2Fixture *fixture;

}
@property(nonatomic, assign) b2Body *body;
@property(nonatomic, assign) b2Fixture *fixture;


- (id)initWithGameObject:(CCNode *)aGameObject collisionGroupId:(int)collisionId width:(float)width height:(float)height;

- (void)setCollisionGroupId:(int16)newCollisionGroup;

@end