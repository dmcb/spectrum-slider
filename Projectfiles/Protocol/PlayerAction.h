//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class PlayerActionContext;

@protocol PlayerAction <NSObject>
- (bool)isDone;

- (void)doAction:(PlayerActionContext *)actionContext delta:(float)delta;
@end