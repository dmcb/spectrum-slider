//
//  Axe.h
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovingObject.h"

@interface Axe : MovingObject {
    b2Body *pivotBody;
    b2Body *axeHandleBody;

    float32 width;
    float32 height;

    float32 axeHeight;

    bool hasAxeHead;
}
- (id)initWithWidth:(float32)aWidth height:(float32)aHeight axeHeight:(float32)anAxeHeight;

- (void)spawn;

@end
