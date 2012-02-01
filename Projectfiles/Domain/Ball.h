//
//  Ball.h
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "MovingObject.h"

@interface Ball : MovingObject {

    float32 width;
    float32 height;

    float32 radius;
}

- (id)initWithRadius:(float32)aRadius height:(float32)aHeight width:(float32)aWidth;

-(void) spawn;


@end
