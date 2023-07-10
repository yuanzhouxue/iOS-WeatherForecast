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


//#pragma mark - description
- (NSString *)description{
  return [NSString stringWithFormat:
          @"PlaceItem(name = %@, location = { lng = %f, lat = %f }, formated = %@)",
          self->_name, self->_lng, self->_lat, self->_formattedAddress];
}


@end
