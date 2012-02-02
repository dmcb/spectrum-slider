//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GameWorldLayer.h"
#import "Domain/PrimaryColourDimension.h"
#import "GameContext.h"
#import "Level.h"
#import "CombinationColourDimension.h"




@implementation GameWorldLayer {

}

@synthesize tiledMap;
@synthesize yellowDimension;
@synthesize blueDimension;
@synthesize redDimension;
@synthesize playerLayer;
@synthesize orangeDimension;
@synthesize greenDimension;
@synthesize purpleDimension;


- (id)initWithTileMap:(NSString *)tileMapString {
    self = [super init];
    if (self) {
        redDimension = [[PrimaryColourDimension alloc] initWithColour:@"red"];
        blueDimension = [[PrimaryColourDimension alloc] initWithColour:@"blue"];
        yellowDimension = [[PrimaryColourDimension alloc] initWithColour:@"yellow"];

        orangeDimension = [[CombinationColourDimension alloc] initWithColour:@"orange"];
        greenDimension = [[CombinationColourDimension alloc] initWithColour:@"green"];
        purpleDimension = [[CombinationColourDimension alloc] initWithColour:@"purple"];

        playerLayer = [CCLayer new];

        [self loadTileMap:tileMapString];
    }

    return self;
}

- (void)addObjectToGame:(CCNode *)node collisionLayer:(uint16)collisionID {
    switch (collisionID) {
        case 0xF0:
            [redDimension.spriteLayer addChild:node];
            break;
        case 0xF00:
            [blueDimension.spriteLayer addChild:node];
            break;
        case 0xF000:
            [yellowDimension.spriteLayer addChild:node];
            break;
        case 0xF0F0:
            [orangeDimension.spriteLayer addChild:node];
            break;
        case 0xFF00:
            [greenDimension.spriteLayer addChild:node];
            break;
        case 0x0FF0:
            [purpleDimension.spriteLayer addChild:node];
            break;
    }

}

//- (void)addObjectToGame:(CCNode *)node {
//    [[currentLayer spriteLayer] addChild:node];
//}

- (void)loadTileMap:(NSString *)tmxFileName {

    tiledMap = [CCTMXTiledMap tiledMapWithTMXFile:tmxFileName];

    [redDimension setSpriteLayer:[CCLayer new]];
    [blueDimension setSpriteLayer:[CCLayer new]];
    [yellowDimension setSpriteLayer:[CCLayer new]];

    [greenDimension setSpriteLayer:[CCLayer new]];
    [orangeDimension setSpriteLayer:[CCLayer new]];
    [purpleDimension setSpriteLayer:[CCLayer new]];

    [redDimension addChildDimension:orangeDimension];
    [redDimension addChildDimension:purpleDimension];

    [blueDimension addChildDimension:purpleDimension];
    [blueDimension addChildDimension:greenDimension];

    [yellowDimension addChildDimension:orangeDimension];
    [yellowDimension addChildDimension:greenDimension];

    [redDimension setTiledLayer:[tiledMap layerNamed:@"Red"]];
    [blueDimension setTiledLayer:[tiledMap layerNamed:@"Blue"]];
    [yellowDimension setTiledLayer:[tiledMap layerNamed:@"Yellow"]];

    [redDimension setCollisionGroupId:0xF0];
    [blueDimension setCollisionGroupId:0xF00];
    [yellowDimension setCollisionGroupId:0xF000];

    orangeDimension.collisionGroupId = 0xF0F0;
    greenDimension.collisionGroupId = 0xFF00;
    purpleDimension.collisionGroupId = 0x0FF0;

}

@end