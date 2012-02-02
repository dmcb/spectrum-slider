//
//  CombinationColorDimension.m
//  Spectrum-Slider
//
//

#import "CombinationColourDimension.h"

@implementation CombinationColourDimension

@synthesize collisionGroupId;
@synthesize spriteLayer;

- (id)initWithColour:(NSString *)string {
    self = [super init];
    if (self) {
        colour = string;
    }
    return self;
}

- (void)activate {
    [spriteLayer setVisible:true];
}

- (void)deactivate {
    [spriteLayer setVisible:false];
}

@end
