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


- (id)init:(NSDictionary*)dict {
    self = [super init];
    if (self) {
        self->_name = [dict valueForKey:@"name"];
        
        NSDictionary *loc = [dict valueForKey:@"location"];
        self->_lat = [(NSNumber*)[loc valueForKey:@"lat"] doubleValue];
        self->_lng = [(NSNumber*)[loc valueForKey:@"lng"] doubleValue];
        
        self->_formattedAddress = [dict valueForKey:@"formatted_address"];
        self->_placeId = [dict valueForKey:@"place_id"];
    }
    return self;
}

//#pragma mark - description
- (NSString *)description{
  return [NSString stringWithFormat:
          @"PlaceItem(name = %@, location = { lng = %f, lat = %f }, formated = %@)",
          self->_name, self->_lng, self->_lat, self->_formattedAddress];
}


@end
