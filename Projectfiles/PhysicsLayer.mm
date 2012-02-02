/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "PhysicsLayer.h"
#import "Level.h"
#import "GameContext.h"
#import "Player.h"
#import "GameWorldLayer.h"
#import "HUDLayer.h"
#import "Domain/PrimaryColourDimension.h"
#import "PlayerLayer.h"
#import "CombinationColourDimension.h"


//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
const float PTM_RATIO = 32.0f;

@interface PhysicsLayer (PrivateMethods)
//-(void) enableBox2dDebugDrawing;
- (b2Vec2)toMeters:(CGPoint)point;

- (CGPoint)toPixels:(b2Vec2)vec;
@end

@interface PhysicsLayer ()
- (void)enableBox2dDebugDrawing;

@end

@implementation PhysicsLayer

- (id)init {
    if ((self = [super init])) {
        CCLOG(@"%@ init", NSStringFromClass([self class]));

        glClearColor(0.1f, 0.0f, 0.2f, 1.0f);

        Level *level = [[Level alloc] init];

        [[GameContext sharedContext] setCurrentLevel:level];

        HUDLayer *hudLayer = [HUDLayer new];

        Level *currentLevel = [[GameContext sharedContext] currentLevel];
        GameWorldLayer *gameWorldLayer = [currentLevel gameWorldLayer];
        [currentLevel setHudLayer:hudLayer];

        [self addChild:gameWorldLayer.tiledMap];
        [self addChild:gameWorldLayer.playerLayer];

        [self addChild:gameWorldLayer.redDimension.spriteLayer];
        [self addChild:gameWorldLayer.blueDimension.spriteLayer];
        [self addChild:gameWorldLayer.yellowDimension.spriteLayer];

        [self addChild:gameWorldLayer.orangeDimension.spriteLayer];
        [self addChild:gameWorldLayer.greenDimension.spriteLayer];
        [self addChild:gameWorldLayer.purpleDimension.spriteLayer];

        [currentLevel initStaticBodies:gameWorldLayer.tiledMap collisionLayer:@"Collision_ALL" collisionGroupId:0xF];
        [currentLevel initStaticBodies:gameWorldLayer.tiledMap collisionLayer:@"Collision_RED" collisionGroupId:0xF0];
        [currentLevel initStaticBodies:gameWorldLayer.tiledMap collisionLayer:@"Collision_BLUE" collisionGroupId:0xF00];
        [currentLevel initStaticBodies:gameWorldLayer.tiledMap collisionLayer:@"Collision_YELLOW" collisionGroupId:0xF000];

        [currentLevel initMovingObjects:gameWorldLayer.tiledMap];

        // Level starts with red dimension
        [currentLevel setDimension:[gameWorldLayer redDimension]];

        Player *player = [[Player alloc] init];

        player.position = ccp(100, 100);

        [player spawn];

        [self addChild:hudLayer];

//        [self enableBox2dDebugDrawing];

        [self scheduleUpdate];

    }

    return self;
}


- (void)enableBox2dDebugDrawing {
    float debugDrawScaleFactor = 1.0f;
#if KK_PLATFORM_IOS
    debugDrawScaleFactor = [[CCDirector sharedDirector] contentScaleFactor];
#endif
    debugDrawScaleFactor *= PTM_RATIO;

    debugDraw = new GLESDebugDraw(debugDrawScaleFactor);

    if (debugDraw) {
        UInt32 debugDrawFlags = 0;
        debugDrawFlags += b2Draw::e_shapeBit;
        debugDrawFlags += b2Draw::e_jointBit;
        //debugDrawFlags += b2Draw::e_aabbBit;
        //debugDrawFlags += b2Draw::e_pairBit;
        //debugDrawFlags += b2Draw::e_centerOfMassBit;

        debugDraw->SetFlags(debugDrawFlags);
        [[[GameContext sharedContext] currentLevel] enableDebugDraw:debugDraw];
    }
}


- (void)update:(ccTime)delta {
    [[GameContext sharedContext] update:delta];
}


// convenience method to convert a CGPoint to a b2Vec2
- (b2Vec2)toMeters:(CGPoint)point {
    return b2Vec2(point.x / PTM_RATIO, point.y / PTM_RATIO);
}

// convenience method to convert a b2Vec2 to a CGPoint
- (CGPoint)toPixels:(b2Vec2)vec {
    return ccpMult(CGPointMake(vec.x, vec.y), PTM_RATIO);
}


#if DEBUG
- (void)draw {

    if (debugDraw) {
        // these GL states must be disabled/enabled otherwise drawing debug data will not render and may even crash
        glDisable(GL_TEXTURE_2D);
        glDisableClientState(GL_COLOR_ARRAY);
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
        glEnableClientState(GL_VERTEX_ARRAY);

        [[[GameContext sharedContext] currentLevel] drawDebugData];

        glDisableClientState(GL_VERTEX_ARRAY);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glEnableClientState(GL_COLOR_ARRAY);
        glEnable(GL_TEXTURE_2D);
    }

    [super draw];
}
#endif

@end
