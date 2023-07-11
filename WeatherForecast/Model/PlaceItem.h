//
//  PlaceItem.h
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#ifndef PlaceItem_h
#define PlaceItem_h

#import "DataModelBase.h"

@interface PlaceItem : DataModelBase

@property (readonly) NSString *placeId;
@property (readonly) NSString *name;
@property (readonly) NSString *formatted_address;
@property (readonly) NSNumber *lng;
@property (readonly) NSNumber *lat;

@end


#endif /* PlaceItem_h */
