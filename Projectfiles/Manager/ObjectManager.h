//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Updateable.h"

@class Player;

@interface ObjectManager : NSObject <Updateable> {
    NSMutableArray *objectsInPlay;
}

@property(nonatomic, strong) NSMutableArray *objectsInPlay;

-(void) addObjectToPlay:(id<Updateable>)unit;
-(void) removeObjectFromPlay:(id<Updateable>)unit;

@end