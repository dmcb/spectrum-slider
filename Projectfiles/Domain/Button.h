//
//  Button.h
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovingObject.h"
#import "Triggerable.h"

@class Trigger;

@interface Button : MovingObject
{
    Trigger *trigger;

    float32 width;
    float32 height;

    float density;

    b2Body *triggerPlateBody;
    b2Fixture *triggerPlateFixture;
    b2PrismaticJoint *triggerJoint;

    bool isTriggered;
}

- (id)initWithTrigger:(Trigger *)aTrigger width:(float32)aWidth height:(float32)aHeight density:(float)aDensity;

- (void)spawn;


@end
