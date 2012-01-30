//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GameWorldLayer.h"
#import "ColorDimension.h"
#import "GameContext.h"
#import "Level.h"


@implementation GameWorldLayer {

}

@synthesize tiledMap;
@synthesize yellowDimension;
@synthesize blueDimension;
@synthesize redDimension;
@synthesize playerLayer;

- (id)initWithTileMap:(NSString *)tileMapString {
    self = [super init];
    if (self) {
        redDimension = [[ColorDimension alloc] initWithColour:@"red"];
        blueDimension = [[ColorDimension alloc] initWithColour:@"blue"];
        yellowDimension = [[ColorDimension alloc] initWithColour:@"yellow"];

        playerLayer = [CCLayer new];

        [self loadTileMap:tileMapString];
    }

    return self;
}

- (void)addObjectToGame:(CCNode *)node {
    [[currentLayer spriteLayer] addChild:node];
}

- (void)loadTileMap:(NSString *)tmxFileName {

    tiledMap = [CCTMXTiledMap tiledMapWithTMXFile:tmxFileName];

    [redDimension setSpriteLayer:[CCLayer new]];
    [blueDimension setSpriteLayer:[CCLayer new]];
    [yellowDimension setSpriteLayer:[CCLayer new]];

    [redDimension setTiledLayer:[tiledMap layerNamed:@"Red"]];
    [blueDimension setTiledLayer:[tiledMap layerNamed:@"Blue"]];
    [yellowDimension setTiledLayer:[tiledMap layerNamed:@"Yellow"]];

    [redDimension setCollisionGroupId:1];
    [blueDimension setCollisionGroupId:2];
    [yellowDimension setCollisionGroupId:3];

}

@end