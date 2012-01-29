//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ColorDimension.h"
#import "GameContext.h"
#import "Level.h"
#import "Player.h"
#import "CollisionVolume.h"


@implementation ColorDimension {

}

@synthesize collisionGroupId;
@synthesize spriteLayer;
@synthesize tiledLayer;


- (void)activate {
    [spriteLayer setVisible:true];

    [tiledLayer setVisible:true];

    [[[[[GameContext sharedContext] currentLevel] player] collisionVolume] setCollisionGroupId:collisionGroupId];
}

- (void)deactivate {
    [spriteLayer setVisible:false];
    [tiledLayer setVisible:false];
}

@end