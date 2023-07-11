//
//  PlaceItem.m
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//
#import "PlaceItem.h"

@interface PlaceItem ()

@end

@implementation PlaceItem

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"location"]) {
        NSDictionary *dict = (NSDictionary*)value;
        self->_lng = [dict valueForKey:@"lng"];
        self->_lat = [dict valueForKey:@"lat"];
    }
}

@end
