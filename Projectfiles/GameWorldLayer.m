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

@synthesize tiledMap;


- (id)initWithTileMap:(NSString *)tileMapString {
    self = [super init];
    if (self) {
        [self loadTileMap:tileMapString];

        blueLayer = [CCLayer new];
        redLayer = [CCLayer new];
        yellowLayer = [CCLayer new];

        currentLayer = redLayer;
    }

    return self;
}

- (void)addObjectToGame:(CCNode *)node {
    [currentLayer addChild:node];
}

- (void)loadTileMap:(NSString *)tmxFileName {

    tiledMap = [CCTMXTiledMap tiledMapWithTMXFile:tmxFileName];



}

@end