//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CollisionVolume.h"
#import "GameContext.h"
#import "Level.h"

const float PTM_RATIO = 32.0f;

@implementation CollisionVolume {

}

@synthesize body;
@synthesize fixture;


- (id)initWithGameObject:(CCNode *)aGameObject collisionGroupId:(int)collisionId width:(float)width height:(float)height {
    self = [super init];
    if (self) {
        gameObject = aGameObject;

        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(gameObject.position.x / PTM_RATIO, gameObject.position.y / PTM_RATIO);
        bodyDef.fixedRotation = true;

        bodyDef.userData = (__bridge void *) aGameObject;

        body = [[[GameContext sharedContext] currentLevel] initBody:&bodyDef];

        b2PolygonShape collisionShape;
        collisionShape.SetAsBox(width / PTM_RATIO * 0.5, height / PTM_RATIO * 0.5);

        // todo make these parameters. (density and such)

        b2FixtureDef shapeDef;
        shapeDef.shape = &collisionShape;
        shapeDef.density = 4.0f;
        shapeDef.friction = 1.0f;
        shapeDef.restitution = 0.0f;

//        shapeDef.isSensor = true;
        shapeDef.userData = (__bridge void *) aGameObject;
        shapeDef.filter.groupIndex = (int16) collisionId;

        body->SetAngularDamping(1.0f);

        fixture = body->CreateFixture(&shapeDef);

//        //shape definition for foot
//        b2PolygonShape polygonShape;
//        polygonShape.SetAsBox(1, 2); //a 2x4 rectangle
//
//        //fixture definition
//        b2FixtureDef myFixtureDef;
//        myFixtureDef.shape = &polygonShape;
//        myFixtureDef.density = 1;
//
//        b2Fixture *footSensorFixture = body->CreateFixture(&myFixtureDef);
//        footSensorFixture->SetUserData((void *) 3);

    }

    return self;
}

- (void)update:(ccTime)delta {
    b2Vec2 position = body->GetPosition();
    gameObject.position = ccp(position.x * PTM_RATIO, position.y * PTM_RATIO);
    gameObject.rotation = -1 * CC_RADIANS_TO_DEGREES(body->GetAngle());
}

- (void)setCollisionGroupId:(int16)newCollisionGroup {
    b2Filter myFilterData = fixture->GetFilterData();

    myFilterData.groupIndex = newCollisionGroup;

    fixture->SetFilterData(myFilterData);
}
@end