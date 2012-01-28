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


- (id)init {
    self = [super init];
    if (self) {
        redLayer = [CCLayer new];
        blueLayer = [CCLayer new];
        yellowLayer = [CCLayer new];

        currentLayer = redLayer;
    }

    return self;
}

- (void) addObjectToGame:(CCNode *)node {
    [currentLayer addChild:node];
}

@end