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

DECLARE_ARRAY_MEMBER(Places, places, PlaceItem)

- (NSString*)description {
    return [NSString stringWithFormat:@"PlaceList(items = %@)", self->_places];
}

@end
