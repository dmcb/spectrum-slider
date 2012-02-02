//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class PrimaryColourDimension;
@class CombinationColourDimension;

@interface GameWorldLayer : CCLayer {

    PrimaryColourDimension *redDimension;
    PrimaryColourDimension *blueDimension;
    PrimaryColourDimension *yellowDimension;

    CombinationColourDimension *orangeDimension;
    CombinationColourDimension *greenDimension;
    CombinationColourDimension *purpleDimension;

    CCTMXTiledMap *tiledMap;

    CCLayer *playerLayer;
}

@property(nonatomic, retain) CCTMXTiledMap *tiledMap;

@property(nonatomic, strong) PrimaryColourDimension *yellowDimension;
@property(nonatomic, strong) PrimaryColourDimension *blueDimension;
@property(nonatomic, strong) PrimaryColourDimension *redDimension;

@property(nonatomic, retain) CCLayer *playerLayer;

@property(nonatomic, strong) CombinationColourDimension *orangeDimension;
@property(nonatomic, strong) CombinationColourDimension *greenDimension;
@property(nonatomic, strong) CombinationColourDimension *purpleDimension;

- (id)initWithTileMap:(NSString *)tileMapString;

- (void)addObjectToGame:(CCNode *)node collisionLayer:(uint16)collisionID;

- (void)loadTileMap:(NSString *)tmxFileName;

@end