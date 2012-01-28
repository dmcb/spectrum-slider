//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class Level;


@interface GameContext : NSObject {
    Level *currentLevel;
}

@property(nonatomic, strong) Level *currentLevel;

+ (GameContext *)sharedContext;

- (void)update:(float)delta;

@end