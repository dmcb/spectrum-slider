//
//  HeadSensor.m
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadSensor.h"
#import "MovingObject.h"

@implementation HeadSensor

@synthesize isCollidingWithSomething;
@synthesize headFixture;


- (id)initWithBody:(b2Body *)body width:(float32)aWidth height:(float32)aHeight
{
    self = [super init];

    if (self) {

        b2CircleShape circleShape;
        circleShape.m_p.Set(0, aHeight / PTM_RATIO * 0.5);
        circleShape.m_radius = aWidth / PTM_RATIO * 0.5;

        b2FixtureDef footSensorDef;
        footSensorDef.isSensor = true;
        footSensorDef.shape = &circleShape;
        footSensorDef.userData = (__bridge void *) self;

        headFixture = body->CreateFixture(&footSensorDef);
    }

    return self;
}

@end
