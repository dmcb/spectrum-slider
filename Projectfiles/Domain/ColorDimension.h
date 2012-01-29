//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface ColorDimension : NSObject {
    CCTMXLayer *tiledLayer;
    CCLayer *spriteLayer;
    int collisionGroupId;
}

@property(nonatomic) int collisionGroupId;
@property(nonatomic, strong) CCLayer *spriteLayer;
@property(nonatomic, strong) CCTMXLayer *tiledLayer;

-(void) activate;
-(void) deactivate;

@end