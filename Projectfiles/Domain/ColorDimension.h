//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface ColorDimension : NSObject {
    CCTMXLayer *tiledLayer;
    CCLayer *spriteLayer;
    uint16 collisionGroupId;
    NSString *colour;
}

@property(nonatomic) uint16 collisionGroupId;
@property(nonatomic, strong) CCLayer *spriteLayer;
@property(nonatomic, strong) CCTMXLayer *tiledLayer;
@property(nonatomic, strong, readonly) NSString *colour;

- (id)initWithColour:(NSString *)aColour;
-(void) activate;
-(void) deactivate;

@end