//
//  NSArray+Map.m
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#import "NSArray+Map.h"


@implementation NSArray (Map)

- (NSArray*)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [result addObject:block(obj, idx)];
    }];
    return result;
}
- (NSArray*)filterObjectsUsingBlock:(BOOL (^)(id obj, NSUInteger idx))block {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (block(obj, idx)) {
            [result addObject:obj];
        }
    }];
    return result;
}

@end
