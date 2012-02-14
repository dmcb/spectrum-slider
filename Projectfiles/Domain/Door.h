//
//  Door.h
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovingObject.h"
#import "Triggerable.h"

@interface Door : MovingObject <Triggerable> {

    float32 width;
    float32 height;

    bool closeIfNotTriggered;

}

- (id)initWithHeight:(float32)aHeight width:(float32)aWidth closeIfNotTriggered:(bool)aCloseIfNotTriggered;

- (void)spawn;

@end
