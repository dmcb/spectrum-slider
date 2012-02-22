//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CollisionManager.h"
#import "CC3Fog.h"
#import "NSString+HexValue.h"
#import "Ball.h"
#import "Crate.h"
#import "GameContext.h"
#import "Level.h"
#import "GameWorldLayer.h"
#import "Axe.h"
#import "Door.h"
#import "Button.h"
#import "Trigger.h"
#import "Goal.h"

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

- (void)initMovingObjects:(CCTMXTiledMap *)map {

    Level *level = [[GameContext sharedContext] currentLevel];

    CCTMXObjectGroup *collisionGroup = [map objectGroupNamed:@"Objects"];

        if (collisionGroup) {
            for (NSMutableDictionary *object in [collisionGroup objects]) {

                float x = [[object valueForKey:@"x"] floatValue];
                float y = [[object valueForKey:@"y"] floatValue];

                float width = [[object valueForKey:@"object_width"] floatValue];
                float height = [[object valueForKey:@"object_height"] floatValue];

                uint16 cid = (uint16) [[object valueForKey:@"object_cid"] hexValue];

                id typeKey = [object valueForKey:@"type"];

                NSString *triggerKey = [object valueForKey:@"object_trigger"];

                Trigger *trigger;
                if (triggerKey) {
                    trigger = [level createOrAddTrigger:triggerKey];
                }

                NSLog(@"Creating Object %s { width:%f height:%f x:%f y:%f cid:%i }", typeKey, width, height, x, y, cid);

                if ([typeKey isEqualToString:@"Ball"]) {
                    
                    float radius = [[object valueForKey:@"object_radius"] floatValue];

                    Ball *ball = [[Ball alloc] initWithRadius:radius height:height width:width];

                    [ball setPosition:ccp(x, y)];

                    [ball spawn];

                    [ball setCollisionGroupId:cid];

                    [[level gameWorldLayer] addObjectToGame:ball.display collisionLayer:cid];

                } else if ([typeKey isEqualToString:@"Crate"]) {

                    Crate *crate = [[Crate alloc] initWithHeight:height width:width];

                    [crate setPosition:ccp(x, y)];

                    [crate spawn];

                    [crate setCollisionGroupId:cid];

                    [[level gameWorldLayer] addObjectToGame:crate.display collisionLayer:cid];

                } else if ([typeKey isEqualToString:@"Axe"]) {

                    float axeHeight = [[object valueForKey:@"object_axe_height"] floatValue];

                    Axe *axe = [[Axe alloc] initWithWidth:width height:height axeHeight:axeHeight];

                    [axe setPosition:ccp(x, y)];

                    [axe spawn];

                    [axe setCollisionGroupId:cid];

                    [[level gameWorldLayer] addObjectToGame:axe.display collisionLayer:cid];

                } else if ([typeKey isEqualToString:@"Door"]) {

                    NSString *closeIfNotTriggered = [object valueForKey:@"object_closeIfNotTriggered"];

                    Door *door = [[Door alloc] initWithHeight:height width:width closeIfNotTriggered:[closeIfNotTriggered boolValue]];

                    [door setPosition:ccp(x, y)];

                    [door spawn];

                    [door setCollisionGroupId:cid];

                    [[level gameWorldLayer] addObjectToGame:door.display collisionLayer:cid];

                    [trigger addListener:door];

                } else if ([typeKey isEqualToString:@"Button"]) {

                    assert(trigger != nil);

                    Button *button = [[Button alloc] initWithTrigger:trigger width:width height:height density:0];

                    [button setPosition:ccp(x, y)];

                    [button spawn];

                    [button setCollisionGroupId:cid];

                    [[level gameWorldLayer] addObjectToGame:button.display collisionLayer:cid];

                } else if ([typeKey isEqualToString:@"Goal"]) {

                    Goal *goal = [[Goal alloc] init];

                    [goal setPosition:ccp(x, y)];

                    [goal spawn];

                    [goal setCollisionGroupId:cid];

                    [[level gameWorldLayer] addObjectToGame:goal.display collisionLayer:cid];

                }

            }
        }
}

- (b2Joint *)initJoint:(b2JointDef *)def
{
    return world->CreateJoint(def);
}

- (void)deleteBody:(b2Body *)bodyToDelete
{
    world->DestroyBody(bodyToDelete);
}

@end