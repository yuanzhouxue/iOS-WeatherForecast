//
//  LocationStorage.h
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#ifndef LocationStorage_h
#define LocationStorage_h

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSNumber *lng;
@property (readonly, nonatomic) NSNumber *lat;

@end

@interface LocationStorage : NSObject

+ (Location*) getSavedLocation;
+ (void) saveLocation:(NSString*)name andLng:(NSNumber*)lng andLat:(NSNumber*)lat;

@end

#endif /* LocationStorage_h */
