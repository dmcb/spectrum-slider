//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CollisionManager.h"

const float PTM_RATIO = 32.0f;

@implementation CollisionManager {

}

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
    CCDirector *director = [CCDirector sharedDirector];

    if (director.currentPlatformIsIOS) {

        KKInput *input = [KKInput sharedInput];

        if (director.currentDeviceIsSimulator == NO) {
            KKAcceleration *acceleration = input.acceleration;
            b2Vec2 gravity = 10.0f * b2Vec2(acceleration.rawX, acceleration.rawY);
            world->SetGravity(gravity);
        }

    }

    float timeStep = 1.0f / 60.0f;
    int32 velocityIterations = 8;
    int32 positionIterations = 1;
    world->Step(timeStep, velocityIterations, positionIterations);
}


- (b2Body)initBody:(b2BodyDef *)def {
    return world->CreateBody(def);
}

@end