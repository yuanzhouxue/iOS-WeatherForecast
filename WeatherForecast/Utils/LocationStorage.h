//
//  LocationStorage.h
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#ifndef LocationStorage_h
#define LocationStorage_h

#import <Foundation/Foundation.h>
#import "WeatherForecast+CoreDataModel.h"

@interface LocationStorage : NSObject

+ (instancetype)sharedInstance;

- (id) init;
- (Location*) getSavedLocation;
- (void) saveLocation:(NSString*)name andLng:(double)lng andLat:(double)lat;

@end

#endif /* LocationStorage_h */
