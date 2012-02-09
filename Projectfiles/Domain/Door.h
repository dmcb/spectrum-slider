//
//  Door.h
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovingObject.h"

@interface Door : MovingObject {

    float32 width;
    float32 height;

}

- (id)initWithHeight:(float32)aHeight width:(float32)aWidth triggerName:(NSString *)aTriggerName;

- (void)spawn;

- (void)trigger;

@end
