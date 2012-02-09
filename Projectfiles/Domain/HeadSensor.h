//
//  HeadSensor.h
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-02-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadSensor : NSObject {

    b2Fixture *headFixture;

    bool isCollidingWithSomething;

}

@property (nonatomic) bool isCollidingWithSomething;
@property (nonatomic) b2Fixture *headFixture;


- (id)initWithBody:(b2Body *)body width:(float32)aWidth height:(float32)aHeight;

@end
