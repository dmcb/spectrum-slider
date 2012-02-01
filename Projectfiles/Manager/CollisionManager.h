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
}

@property(nonatomic) b2World *world;

- (b2Body *)initBody:(b2BodyDef *)def;

- (void)draw;

- (void)initStaticBodies:(CCTMXTiledMap *)map collisionLayer:(NSString *)clLayer collisionGroupId:(uint16)collisionGroupId;

- (void)initMovingObjects:(CCTMXTiledMap *)map;
@end