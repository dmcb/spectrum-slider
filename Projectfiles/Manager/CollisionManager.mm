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
        b2Vec2 gravity = b2Vec2(0.0f, -10.0f);
        world = new b2World(gravity);
        world->SetAllowSleeping(YES);
        //world->SetContinuousPhysics(YES);

        // uncomment this line to draw debug info
        //[self enableBox2dDebugDrawing];

        contactListener = new ContactListener();
        world->SetContactListener(contactListener);

        // for the screenBorder body we'll need these values
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        float widthInMeters = screenSize.width / PTM_RATIO;
        float heightInMeters = screenSize.height / PTM_RATIO;
        b2Vec2 lowerLeftCorner = b2Vec2(0, 0);
        b2Vec2 lowerRightCorner = b2Vec2(widthInMeters, 0);
        b2Vec2 upperLeftCorner = b2Vec2(0, heightInMeters);
        b2Vec2 upperRightCorner = b2Vec2(widthInMeters, heightInMeters);

        // Define the static container body, which will provide the collisions at screen borders.
        b2BodyDef screenBorderDef;
        screenBorderDef.position.Set(0, 0);
        b2Body *screenBorderBody = world->CreateBody(&screenBorderDef);
        b2EdgeShape screenBorderShape;

        // Create fixtures for the four borders (the border shape is re-used)
        screenBorderShape.Set(lowerLeftCorner, lowerRightCorner);
        screenBorderBody->CreateFixture(&screenBorderShape, 0);
        screenBorderShape.Set(lowerRightCorner, upperRightCorner);
        screenBorderBody->CreateFixture(&screenBorderShape, 0);
        screenBorderShape.Set(upperRightCorner, upperLeftCorner);
        screenBorderBody->CreateFixture(&screenBorderShape, 0);
        screenBorderShape.Set(upperLeftCorner, lowerLeftCorner);
        screenBorderBody->CreateFixture(&screenBorderShape, 0);

    }
    return self;
}

- (void)update:(ccTime)delta {
    float timeStep = 0.03f;
    int32 velocityIterations = 8;
    int32 positionIterations = 1;
    world->Step(timeStep, velocityIterations, positionIterations);
}


- (b2Body *)initBody:(b2BodyDef *)def {
    return world->CreateBody(def);
}

-(void) draw {
    world->DrawDebugData();
}

- (void)initStaticBodies:(CCTMXTiledMap *)map collisionLayer:(NSString *)clLayer collisionGroupId:(int)collisionGroupId {

    CCTMXObjectGroup *collisionGroup = [map objectGroupNamed:clLayer];

    if (collisionGroup) {
        for (NSMutableDictionary *object in [collisionGroup objects]) {

            float width = [[object valueForKey:@"width"] floatValue];
            float height = [[object valueForKey:@"height"] floatValue];

            b2BodyDef bodyDef;
            bodyDef.type = b2_staticBody    ;
            bodyDef.position.Set(([[object valueForKey:@"x"] floatValue] / PTM_RATIO) + (width / 2.0 / PTM_RATIO),
            ([[object valueForKey:@"y"] floatValue] / PTM_RATIO) + (height / 2.0 / PTM_RATIO));

            b2Body *body = world->CreateBody(&bodyDef);

            b2PolygonShape collisionShape;
            collisionShape.SetAsBox(width / 2.0 / PTM_RATIO ,
                    height / 2.0 / PTM_RATIO );


            b2Fixture *fixture = body->CreateFixture(&collisionShape, 0.0f);

            b2Filter filter = fixture->GetFilterData();

            filter.groupIndex = collisionGroupId;

            fixture->SetFilterData(filter);
        }

    }

}

@end