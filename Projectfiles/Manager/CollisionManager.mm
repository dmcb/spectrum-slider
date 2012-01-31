//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CollisionManager.h"

const float PTM_RATIO = 32.0f;

@implementation CollisionManager {

}

@synthesize world;

- (id)init {
    self = [super init];
    if (self) {
        b2Vec2 gravity = b2Vec2(0.0f, -30.0f);
        world = new b2World(gravity);
        world->SetAllowSleeping(YES);
        //world->SetContinuousPhysics(YES);

        // uncomment this line to draw debug info
        //[self enableBox2dDebugDrawing];

        contactListener = new ContactListener();
        world->SetContactListener(contactListener);

        // for the screenBorder body we'll need these values
        CGSize screenSize = [CCDirector sharedDirector].winSize;

    }
    return self;
}

- (void)update:(ccTime)delta {
    float timeStep = 1.0f/60.0f;
    int32 velocityIterations = 8;
    int32 positionIterations = 10;
    world->Step(timeStep, velocityIterations, positionIterations);
}


- (b2Body *)initBody:(b2BodyDef *)def {
    return world->CreateBody(def);
}

-(void) draw {
    world->DrawDebugData();
}

- (void)initStaticBodies:(CCTMXTiledMap *)map collisionLayer:(NSString *)clLayer collisionGroupId:(uint16)collisionGroupId {

    CCTMXObjectGroup *collisionGroup = [map objectGroupNamed:clLayer];

    if (collisionGroup) {
        for (NSMutableDictionary *object in [collisionGroup objects]) {

            float width = [[object valueForKey:@"width"] floatValue];
            float height = [[object valueForKey:@"height"] floatValue];

            b2BodyDef bodyDef;
            bodyDef.type = b2_staticBody;
            bodyDef.position.Set(([[object valueForKey:@"x"] floatValue] / PTM_RATIO) + (width / 2.0 / PTM_RATIO),
            ([[object valueForKey:@"y"] floatValue] / PTM_RATIO) + (height / 2.0 / PTM_RATIO));

            b2Body *body = world->CreateBody(&bodyDef);

            b2PolygonShape collisionShape;
            collisionShape.SetAsBox(width / 2.0 / PTM_RATIO ,
                    height / 2.0 / PTM_RATIO );


            b2Fixture *fixture = body->CreateFixture(&collisionShape, 0.0f);

            b2Filter filter = fixture->GetFilterData();

            filter.categoryBits = collisionGroupId;

            fixture->SetFilterData(filter);
            fixture->SetFriction(1.0f);
        }

    }

}

@end