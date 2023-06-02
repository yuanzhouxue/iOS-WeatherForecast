//
//  NSArray+Map.h
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Map)

- (NSArray*)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block;

- (NSArray*)filterObjectsUsingBlock:(BOOL (^)(id obj, NSUInteger idx))block;

@end

NS_ASSUME_NONNULL_END
