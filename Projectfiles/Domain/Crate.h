//
//  Crate.h
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "MovingObject.h"

@interface Crate : MovingObject {
    float32 width;
    float32 height;
}

- (id)initWithHeight:(float32)aHeight width:(float32)aWidth;

- (void)spawn;

@end
