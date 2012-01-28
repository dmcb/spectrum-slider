//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Updateable.h"

@class CollisionManager;
@class ObjectManager;


@interface Level : NSObject <Updateable> {

    CollisionManager *collisionManager;
    ObjectManager *objectManager;

}

-(b2Body *) initBody:(b2BodyDef *) fixture;

@end