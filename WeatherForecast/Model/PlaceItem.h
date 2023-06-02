//
//  PlaceItem.h
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#ifndef PlaceItem_h
#define PlaceItem_h

#import <Foundation/Foundation.h>

@interface PlaceItem : NSObject

@property (readonly) NSString *placeId;
@property (readonly) NSString *name;
@property (readonly) NSString *formattedAddress;
@property (readonly) double lng;
@property (readonly) double lat;

- (id)init:(NSDictionary*)dict;

@end


#endif /* PlaceItem_h */
