//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface GameWorldLayer : CCLayer {
    CCTMXLayer *redLayer;
    CCTMXLayer *blueLayer;
    CCTMXLayer *yellowLayer;

    CCTMXLayer *currentLayer;
}


@property(nonatomic, strong) CCTMXLayer *redLayer;
@property(nonatomic, strong) CCTMXLayer *blueLayer;
@property(nonatomic, strong) CCTMXLayer *yellowLayer;

- (id)initWithTileMap:(NSString *)tileMapString;

- (void)addObjectToGame:(CCNode *)node;

- (void)loadTileMap:(NSString *)tmxFileName;

@end