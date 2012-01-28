//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "ContactListener.h"
#import "GLES-Render.h"
#import "Updateable.h"


@interface CollisionManager : NSObject <Updateable> {
    b2World *world;
    ContactListener *contactListener;
    GLESDebugDraw *debugDraw;
}


- (b2Body *)initBody:(b2BodyDef *)def;
@end