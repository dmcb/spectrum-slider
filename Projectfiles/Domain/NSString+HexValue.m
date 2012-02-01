//
//  NSString+HexValue.m
//  Spectrum-Slider
//
//  Created by Kyle Reczek on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+HexValue.h"

@implementation NSString (HexValue)
- (int) hexValue {
	int n = 0;
	sscanf([self UTF8String], "%x", &n);
	return n;
}
@end
