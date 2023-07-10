//
//  CYWeather.h
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/17.
//

#ifndef CYWeather_h
#define CYWeather_h

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#import "PlaceList.h"
#import "Realtime.h"
#import "Daily.h"
#import "CYWeatherAllData.h"

@interface Sky : NSObject

@property (nonatomic, readonly) NSString* desc;
@property (nonatomic, readonly) NSString* ic_image;
@property (nonatomic, readonly) NSString* bg_image;

- (id)init:(NSString*)desc ic:(NSString*)ic_image bg:(NSString*)bg_image;

@end

@interface CYWeather : NSObject

- (id)init;

- (void)getJsonObject:(NSString*)path withPara:(NSDictionary*)paras withHandler:(void (^)(NSDictionary* res))completionHandler;

- (void)searchPlaces:(NSString*)place withHandler:(void (^)(PlaceList* places))handler;

- (void)realtimeLng:(double)lng andLat:(double)lat andHandler:(void (^)(Realtime* res))handler;

- (void)dailyLng:(double)lng andLat:(double)lat andHandler:(void (^)(Daily* res))handler;

- (void)all:(double)lng andLat:(double)lat andHandler:(void (^)(CYWeatherAllData* res)) handler;

+ (Sky*)getSky:(NSString*)desc;

@end


#endif /* CYWeather_h */
