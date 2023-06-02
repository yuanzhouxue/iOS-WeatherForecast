//
//  PlaceList.m
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#import "PlaceList.h"
#import "NSArray+Map.h"

@interface PlaceList ()

@end

@implementation PlaceList


- (id)init:(NSArray*)arr {
    self = [super init];
    if (self) {
        self->_items = [arr mapObjectsUsingBlock:^id _Nonnull(id  _Nonnull obj, NSUInteger idx) {
            return [[PlaceItem alloc] init:obj];
        }];
    }
    return self;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"PlaceList(items = %@)", self->_items];
}

@end
