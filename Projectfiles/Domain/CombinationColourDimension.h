//
//  CombinationColorDimension.h
//  Spectrum-Slider
//
//

#import "CCNode.h"
#import "Dimension.h"

@interface CombinationColourDimension : NSObject <Dimension> {
    CCLayer *spriteLayer;
    uint16 collisionGroupId;
    NSString *colour;
}

@property(nonatomic) uint16 collisionGroupId;
@property(nonatomic, strong) CCLayer *spriteLayer;

- (id)initWithColour:(NSString *)string;
@end
