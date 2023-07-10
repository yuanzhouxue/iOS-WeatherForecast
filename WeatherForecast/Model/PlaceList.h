//
//  PlaceList.h
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#ifndef PlaceList_h
#define PlaceList_h

#import <Foundation/Foundation.h>
#import "PlaceItem.h"
#import "NSArray+Map.h"

@interface PlaceList : DataModelBase

@property (readonly) NSArray<PlaceItem*> *places;

@end


#endif /* PlaceList_h */
