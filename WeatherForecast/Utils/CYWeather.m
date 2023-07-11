//
//  CYWeather.m
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/17.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CYWeather.h"
#import "CYWeatherAllData.h"

@implementation Sky

- (id)init:(NSString *)desc ic:(NSString *)ic_image bg:(NSString *)bg_image {
    if ([super init]) {
        self->_desc = desc;
        self->_ic_image = ic_image;
        self->_bg_image = bg_image;
    }
    return self;
}

@end

@interface CYWeather()


@end

@implementation CYWeather {
    
@private NSString* baseUrl;
@private NSString* token;
    
}


- (id)init {
    self->baseUrl = @"https://api.caiyunapp.com";
    self->token = @"BhrbDSuCE84ToUtn";
    return self;
}

- (void)getJsonObject:(NSString*)path withPara:(NSDictionary*)para withHandler:(void (^)(NSDictionary*))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [configuration setHTTPAdditionalHeaders:@{
        @"Authorization": [NSString stringWithFormat:@"Bearer %@", self->token]
    }];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *req = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                      URLString:[NSString stringWithFormat:@"%@/%@", self->baseUrl, path]
                                                                     parameters:para
                                                                          error:nil];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:req
                                               uploadProgress:nil
                                             downloadProgress:nil
                                            completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error || ![responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error: %@", error);
        } else {
            NSDictionary *result = (NSDictionary*)responseObject;
            completionHandler(result);
        }
    }];
    [task resume];
}

- (void)searchPlaces:(NSString*)place withHandler:(void (^)(PlaceList*))handler {
    NSDictionary *paras = @{
        @"query": place,
        @"lang": @"zh_CN"
    };
    [self getJsonObject:@"v2/place" withPara:paras withHandler:^(NSDictionary *res) {
        PlaceList *place_items = [[PlaceList alloc] initWithDictionary:res];
        handler(place_items);
    }];
}

- (void)realtimeLng:(double)lng andLat:(double)lat andHandler:(void (^)(Realtime* res))handler {
    NSString *path = [NSString stringWithFormat:@"v2.5/%@/%f,%f/realtime.json", self->token, lng, lat];
    [self getJsonObject:path withPara:nil withHandler:^(NSDictionary *res) {
        NSDictionary* result = (NSDictionary*)[res valueForKey:@"result"];
        NSDictionary* realtime = (NSDictionary*)[result valueForKey:@"realtime"];
        Realtime* ret = [[Realtime alloc] initWithDictionary:realtime];
        handler(ret);
    }];
}

- (void)dailyLng:(double)lng andLat:(double)lat andHandler:(void (^)(Daily *))handler {
    NSString *path = [NSString stringWithFormat:@"v2.5/%@/%f,%f/daily?dailysteps=5", self->token, lng, lat];
    [self getJsonObject:path withPara:nil withHandler:^(NSDictionary* res) {
        NSDictionary* result = (NSDictionary*)[res valueForKey:@"result"];
        NSDictionary* daily = (NSDictionary*)[result valueForKey:@"daily"];
        Daily* ret = [[Daily alloc] initWithDictionary:daily];
        handler(ret);
    }];
}

- (void)all:(double)lng andLat:(double)lat andHandler:(void (^)(CYWeatherAllData *))handler {
    NSString *path = [NSString stringWithFormat:@"v2.6/%@/%f,%f/weather?alert=true&dailysteps=15&hourlysteps=24", self->token, lng, lat];
    [self getJsonObject:path withPara:nil withHandler:^(NSDictionary *res) {
        NSDictionary *result = (NSDictionary*)[res valueForKey:@"result"];
        CYWeatherAllData *item = [[CYWeatherAllData alloc] initWithDictionary:result];
        handler(item);
    }];
}

+ (Sky*)getSky:(NSString *)desc {
    NSDictionary* m = @{
        @"CLEAR_DAY": [[Sky alloc] init:@"晴" ic:@"ic_clear_day" bg:@"bg_clear_day"],
        @"CLEAR_NIGHT": [[Sky alloc] init:@"晴" ic:@"ic_clear_night" bg:@"bg_clear_night"],
        @"PARTLY_CLOUDY_DAY": [[Sky alloc] init:@"多云" ic:@"ic_partly_cloud_day" bg:@"bg_partly_cloudy_day"],
        @"PARTLY_CLOUDY_NIGHT": [[Sky alloc] init:@"多云" ic:@"ic_partly_cloud_night" bg:@"bg_partly_cloudy_night"],
        @"CLOUDY": [[Sky alloc] init:@"阴" ic:@"ic_cloudy" bg:@"bg_cloudy"],
        @"LIGHT_HAZE": [[Sky alloc] init:@"轻度雾霾" ic:@"ic_light_haze" bg:@"bg_fog"],
        @"MODERATE_HAZE": [[Sky alloc] init:@"中度雾霾" ic:@"ic_moderate_haze" bg:@"bg_fog"],
        @"HEAVY_HAZE": [[Sky alloc] init:@"重度雾霾" ic:@"ic_heavy_haze" bg:@"bg_fog"],
        @"LIGHT_RAIN": [[Sky alloc] init:@"小雨" ic:@"ic_light_rain" bg:@"bg_rain"],
        @"MODERATE_RAIN": [[Sky alloc] init:@"中雨" ic:@"ic_moderate_rain" bg:@"bg_rain"],
        @"HEAVY_RAIN": [[Sky alloc] init:@"大雨" ic:@"ic_heavy_rain" bg:@"bg_rain"],
        @"STORM_RAIN": [[Sky alloc] init:@"暴雨" ic:@"ic_storm_rain" bg:@"bg_rain"],
        @"FOG": [[Sky alloc] init:@"雾" ic:@"ic_fog" bg:@"bg_fog"],
        @"LIGHT_SNOW": [[Sky alloc] init:@"小雪" ic:@"ic_light_snow" bg:@"bg_snow"],
        @"MODERATE_SNOW": [[Sky alloc] init:@"中雪" ic:@"ic_moderate_snow" bg:@"bg_snow"],
        @"HEAVY_SNOW": [[Sky alloc] init:@"大雪" ic:@"ic_heavy_snow" bg:@"bg_snow"],
        @"STORM_SNOW": [[Sky alloc] init:@"暴雪" ic:@"ic_heavy_snow" bg:@"bg_snow"],
        @"DUST": [[Sky alloc] init:@"浮尘" ic:@"ic_fog" bg:@"bg_fog"],
        @"SAND": [[Sky alloc] init:@"沙尘" ic:@"ic_fog" bg:@"bg_fog"],
        @"WIND": [[Sky alloc] init:@"大风" ic:@"ic_cloudy" bg:@"bg_wind"]
    };
    return [m valueForKey:desc];
}

@end


