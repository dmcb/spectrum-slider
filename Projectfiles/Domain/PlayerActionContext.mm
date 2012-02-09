#import "PlayerActionContext.h"
#import "PlayerAction.h"
#import "MoveAction.h"
#import "objc/runtime.h"

@implementation PlayerActionContext {

}

- (Player *)player {
    return player;
}

- (void)setAction:(id <PlayerAction>)actionToChangeTo {
    action = actionToChangeTo;
}

- (void)queueAction:(id <PlayerAction>)actionToQueue {
    if (queuedActions == nil) {
        queuedActions = [[NSMutableArray alloc] init];
    }
    [queuedActions addObject:actionToQueue];
}

- (void)queueAction:(id <PlayerAction>)actionToQueue atIndex:(NSUInteger)index {
    if (queuedActions == nil) {
        queuedActions = [[NSMutableArray alloc] init];
    }
    [queuedActions insertObject:actionToQueue atIndex:index];
}

- (void)removeActionsFromQueueWithType:(Class)typeToRemove {
    NSMutableArray *objectsToRemove = [NSMutableArray new];

    for (id queuedActionToRemove in queuedActions) {
        if ([queuedActionToRemove isKindOfClass:typeToRemove]) {
            [objectsToRemove addObject:queuedActionToRemove];
        }
    }

    for (id toRemove in objectsToRemove) {
        [queuedActions removeObject:toRemove];
    }

}

- (id <PlayerAction>)getCurrentAction {
    return action;
}

- (bool)actionQueueContainsType:(Class)playerActionTypeToCheckQueueFor
{
    for ( id queuedAction in queuedActions ) {
        if ([queuedAction isKindOfClass:playerActionTypeToCheckQueueFor]) {
            return true;       
        }
    }
    return false;
}


- (bool)isNextActionType:(Class)nextActionsClass {
    if (queuedActions.count <= 0) {
        return false;
    }

    if ([[queuedActions objectAtIndex:0] isKindOfClass:nextActionsClass]) {
        return true;
    }
    return false;
}

- (bool)isCurrentActionType:(Class)nextActionsClass {
    if ([[action class] isKindOfClass:nextActionsClass]) {
        return true;
    }
    return false;
}

- (void)doAction:(float)delta {
    
    //NSLog(@"Do action %s", class_getName([action class]));
    
    if (action != nil) {
        if ([action isDone]) {
            action = nil;
            if (queuedActions != nil && [queuedActions count] > 0) {
                action = [queuedActions objectAtIndex:0];
                [queuedActions removeObjectAtIndex:0];
                [action doAction:self delta:delta];
                
                if ([queuedActions count] == 0) {
                    queuedActions = nil;
                }
            }
        } else {
            [action doAction:self delta:delta];
        }
    } else if (queuedActions != nil && [queuedActions count] > 0) {
        action = [queuedActions objectAtIndex:0];
        [queuedActions removeObjectAtIndex:0];
        [action doAction:self delta:delta];
        
        if ([queuedActions count] == 0) {
            queuedActions = nil;
        }
    }
}

- (void)stopAllActions {
    action = nil;
    [queuedActions removeAllObjects];
}

- (void)setPlayer:(Player *)aPlayer {
    player = aPlayer;
}

- (void)clearQueue {
    [queuedActions removeAllObjects];
}

@end