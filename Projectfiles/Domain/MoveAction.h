//
//  Created by kylereczek on 12-01-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "PlayerAction.h"


@interface MoveAction : NSObject <PlayerAction> {
    CGPoint direction;
    bool done;
}

- (id)initWithDirection:(CGPoint)aDirection;

@end