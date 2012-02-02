//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Dimension.h"

@class CombinationColourDimension;

@interface PrimaryColourDimension : NSObject <Dimension> {
    CCTMXLayer *tiledLayer;
    CCLayer *spriteLayer;
    uint16 collisionGroupId;
    NSString *colour;

    NSMutableArray *childDimensions;
}

@property(nonatomic) uint16 collisionGroupId;
@property(nonatomic, strong) CCLayer *spriteLayer;
@property(nonatomic, strong) CCTMXLayer *tiledLayer;
@property(nonatomic, strong, readonly) NSString *colour;

-(void) addChildDimension:(CombinationColourDimension *)child;
- (id)initWithColour:(NSString *)aColour;
@end