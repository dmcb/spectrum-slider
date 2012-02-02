//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PrimaryColourDimension.h"
#import "GameContext.h"
#import "Level.h"
#import "Player.h"
#import "HUDLayer.h"
#import "CombinationColourDimension.h"

@implementation PrimaryColourDimension {

}

@synthesize collisionGroupId;
@synthesize spriteLayer;
@synthesize tiledLayer;
@synthesize colour;


- (id)initWithColour:(NSString *) aColour
{
    self = [super init];
    if (self)
    {
        colour = aColour;
        childDimensions = [NSMutableArray new];
    }
    return self;
}

- (void) addChildDimension:(CombinationColourDimension *)child
{
    [childDimensions addObject:child];
}

- (void)activate
{
    Level *currentLevel = [[GameContext sharedContext] currentLevel];

    [[currentLevel hudLayer] slideToColour:colour];

    [spriteLayer setVisible:true];

    [tiledLayer setVisible:true];

    [currentLevel changeCollisionGroupForLevel:collisionGroupId];

    for (id dimension in childDimensions)
    {
        [dimension activate];
    }
}

- (void)deactivate
{
    [spriteLayer setVisible:false];
    [tiledLayer setVisible:false];

    for (id dimension in childDimensions)
    {
        [dimension deactivate];
    }
}

@end