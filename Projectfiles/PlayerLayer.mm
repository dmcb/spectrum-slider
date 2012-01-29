//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PlayerLayer.h"
#import "GameContext.h"
#import "Level.h"
#import "Displayable.h"
#import "Player.h"


@implementation PlayerLayer {

}
- (id)init {
    self = [super init];
    if (self) {
        [self addChild:[[[[GameContext sharedContext] currentLevel] player] display]];
    }

    return self;
}


@end