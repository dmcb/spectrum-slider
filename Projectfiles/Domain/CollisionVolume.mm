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

        bodyDef.userData = (__bridge void *) aGameObject;

        body = [[[GameContext sharedContext] currentLevel] initBody:&bodyDef];

        b2PolygonShape collisionShape;
        collisionShape.SetAsBox(width / PTM_RATIO, height / PTM_RATIO);

        // todo make these parameters. (density and such)

        b2FixtureDef shapeDef;
        shapeDef.shape = &collisionShape;
        shapeDef.density = 15.0f;
        shapeDef.friction = 1.0f;
        shapeDef.restitution = 0.0f;
//        shapeDef.isSensor = true;
        shapeDef.userData = (__bridge void *) aGameObject;
        shapeDef.filter.groupIndex = (int16) collisionId;

        body->SetAngularDamping(1.0f);

        fixture = body->CreateFixture(&shapeDef);

    }

    return self;
}

- (void)update:(ccTime)delta {
    b2Vec2 position = body->GetPosition();
    gameObject.position = ccp(position.x * PTM_RATIO, position.y * PTM_RATIO);
    gameObject.rotation = -1 * CC_RADIANS_TO_DEGREES(body->GetAngle());
}

@end