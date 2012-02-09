//
//  Button.h
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovingObject.h"
#import "Triggerable.h"

@interface Button : MovingObject <Triggerable>
{
    NSString *trigger;

    float32 width;
    float32 height;

}

- (id)initWithTrigger:(NSString *)aTrigger width:(float32)aWidth height:(float32)aHeight;

- (void)spawn;


@end
