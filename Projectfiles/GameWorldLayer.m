//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GameWorldLayer.h"


@implementation GameWorldLayer {

}

@synthesize yellowLayer;
@synthesize blueLayer;
@synthesize redLayer;

- (id)initWithTileMap:(NSString *)tileMapString {
    self = [super init];
    if (self) {
        [self loadTileMap:tileMapString];
        currentLayer = redLayer;
    }

    return self;
}

- (void)addObjectToGame:(CCNode *)node {
    [currentLayer addChild:node];
}

- (void)loadTileMap:(NSString *)tmxFileName {

    CCTMXTiledMap *tiledMap = [CCTMXTiledMap tiledMapWithTMXFile:tmxFileName];

    blueLayer = [tiledMap layerNamed:@"Blue"];

    redLayer = [tiledMap layerNamed:@"Red"];

    yellowLayer = [tiledMap layerNamed:@"Yellow"];

}

@end