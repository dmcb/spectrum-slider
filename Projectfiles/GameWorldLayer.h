//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface GameWorldLayer : CCLayer {
    CCLayer *redLayer;
    CCLayer *blueLayer;
    CCLayer *yellowLayer;

    CCLayer *currentLayer;

    CCTMXTiledMap *tiledMap;
}


@property(nonatomic, strong) CCLayer *redLayer;
@property(nonatomic, strong) CCLayer *blueLayer;
@property(nonatomic, strong) CCLayer *yellowLayer;

@property(nonatomic, retain) CCTMXTiledMap *tiledMap;

- (id)initWithTileMap:(NSString *)tileMapString;

- (void)addObjectToGame:(CCNode *)node;

- (void)loadTileMap:(NSString *)tmxFileName;

@end