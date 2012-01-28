//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Player.h"
#import "PlayerActionContext.h"
#import "CollisionVolume.h"
#import "GameContext.h"
#import "Level.h"

@implementation Player {

}

- (id)init {
    self = [super init];

    if (self) {
        actionContext = [PlayerActionContext new];
        sprite = [CCSprite spriteWithFile:@"player.png"];
    }

    return self;
}

- (void)update:(ccTime)delta {
    [collisionVolume update:delta];
    [sprite setPosition:[self position]];
}

- (void)spawn {
    collisionVolume = [[CollisionVolume alloc] initWithGameObject:self collisionGroupId:0 width:sprite.contentSize.width height:sprite.contentSize.height];
    [[[GameContext sharedContext] currentLevel] spawn:self];
}

- (CCSprite *)display {
    return sprite;
}


@end