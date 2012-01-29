//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class ColorDimension;


@interface GameWorldLayer : CCLayer {

    ColorDimension *currentLayer;

    ColorDimension *redDimension;
    ColorDimension *blueDimension;
    ColorDimension *yellowDimension;

    CCTMXTiledMap *tiledMap;

    CCLayer *playerLayer;
}

@property(nonatomic, retain) CCTMXTiledMap *tiledMap;
@property(nonatomic, strong) ColorDimension *yellowDimension;
@property(nonatomic, strong) ColorDimension *blueDimension;
@property(nonatomic, strong) ColorDimension *redDimension;


@property(nonatomic, retain) CCLayer *playerLayer;

- (id)initWithTileMap:(NSString *)tileMapString;

- (void)addObjectToGame:(CCNode *)node;

- (void)loadTileMap:(NSString *)tmxFileName;

@end