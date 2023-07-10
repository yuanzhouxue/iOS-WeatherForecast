//
//  DataModelBase.h
//  WeatherForecast
//
//  Created by ByteDance on 2023/7/10.
//

#ifndef DataModelBase_h
#define DataModelBase_h

#import <Foundation/Foundation.h>

#define DECLARE_ARRAY_MEMBER(NAME, PROPERTY, ITEM_TYPE) \
- (void)set##NAME:(NSArray<ITEM_TYPE *> *)PROPERTY { \
    if (0 == PROPERTY.count || [PROPERTY[0] isKindOfClass:[ITEM_TYPE class]]) { \
        self->_##PROPERTY = PROPERTY;\
    } else if ([PROPERTY[0] isKindOfClass:[NSDictionary class]]) {\
        NSArray *arr = (NSArray<NSDictionary*>*)PROPERTY;\
        NSMutableArray *mutableArr = [[NSMutableArray<ITEM_TYPE*> alloc] initWithCapacity:arr.count];\
        for (NSDictionary* item in arr) {\
            [mutableArr addObject:[[ITEM_TYPE alloc] initWithDictionary:item]];\
        }\
        self->_##PROPERTY = mutableArr.copy;\
    }\
}

#define DECLARE_OBJECT_MEMBER(NAME, PROPERTY, OBJECT_TYPE) \
- (void)set##NAME:(OBJECT_TYPE *)PROPERTY {\
    if ([PROPERTY isKindOfClass:[NSDictionary class]]) {\
        NSDictionary* PROPERTY##Dict = (NSDictionary*)PROPERTY;\
        self->_##PROPERTY = [[OBJECT_TYPE alloc] initWithDictionary:PROPERTY##Dict];\
    } else {\
        self->_##PROPERTY = PROPERTY;\
    }\
}

@interface DataModelBase : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)dict;



@end


#endif /* DataModelBase_h */
