//
//  WinLayer.m
//  Spectrum-Slider
//

#import "WinLayer.h"

@implementation WinLayer {

}

- (id)init
{
    self = [super init];
    if (self) {
        [self addChild:[CCSprite spriteWithFile:@"win_screen.png"]];
    }

    return self;
}

@end
