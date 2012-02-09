//
//  Created by kylereczek on 12-01-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol PlayerAction;
@class Player;

@interface PlayerActionContext : NSObject {
    id <PlayerAction> action;
    NSMutableArray *queuedActions;
    Player *player;
}

- (void)setAction:(id <PlayerAction>)actionToChangeTo;

- (void)queueAction:(id <PlayerAction>)actionToQueue;

- (void)queueAction:(id <PlayerAction>)actionToQueue atIndex:(NSUInteger)index;

- (void)removeActionsFromQueueWithType:(Class)typeToRemove;

- (id <PlayerAction>)getCurrentAction;

- (bool)actionQueueContainsType:(Class)playerActionToCheckQueueFor;

- (bool)isNextActionType:(Class)nextActionsClass;

- (bool)isCurrentActionType:(Class)nextActionsClass;

- (void)doAction:(float)delta;

- (void)stopAllActions;

- (Player *)player;

- (void)setPlayer:(Player *)aPlayer;

- (void)clearQueue;
@end