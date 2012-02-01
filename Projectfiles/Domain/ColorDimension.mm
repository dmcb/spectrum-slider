//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ColorDimension.h"
#import "GameContext.h"
#import "Level.h"
#import "Player.h"
#import "HUDLayer.h"
#import "CollisionVolume.h"


@implementation ColorDimension {

}

@synthesize collisionGroupId;
@synthesize spriteLayer;
@synthesize tiledLayer;
@synthesize colour;

- (id)initWithColour:(NSString *)aColour {
    self = [super init];
    if (self) {
        colour = aColour;
    }
    return self;
}


- (void)activate {
    Level *currentLevel = [[GameContext sharedContext] currentLevel];

    [[currentLevel hudLayer] slideToColour:colour];
    
    [spriteLayer setVisible:true];

    [tiledLayer setVisible:true];

    [currentLevel changeCollisionGroupForLevel:collisionGroupId];
}

- (void)deactivate {
    [spriteLayer setVisible:false];
    [tiledLayer setVisible:false];
}

@end