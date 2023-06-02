//
//  Realtime.m
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#import "Realtime.h"

@implementation LifeIndex

- (id)init:(NSDictionary*)dict {
    self = [super init];
    if (self) {
        self->_comfort = (NSString*)[[dict valueForKey:@"comfort"] valueForKey:@"desc"];
        self->_ultraviolet = (NSString*)[[dict valueForKey:@"ultraviolet"] valueForKey:@"desc"];
    }
    return self;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"舒适度： %@，紫外线：%@", self->_comfort, self->_ultraviolet];
}

@end

@implementation AirQuality

- (id)init:(NSDictionary*)dict {
    if (self = [super init]) {
//        [(NSNumber*)[loc valueForKey:@"lat"] doubleValue];
        self->_aqi = [(NSNumber*)[[dict valueForKey:@"aqi"] valueForKey:@"chn"] intValue];
        self->_desc = [[dict valueForKey:@"description"] valueForKey:@"chn"];
        self->_co = [(NSNumber*)[dict valueForKey:@"co"] intValue];
        self->_no2 = [(NSNumber*)[dict valueForKey:@"no2"] intValue];
        self->_o3 = [(NSNumber*)[dict valueForKey:@"o3"] intValue];
        self->_pm10 = [(NSNumber*)[dict valueForKey:@"pm10"] intValue];
        self->_pm25 = [(NSNumber*)[dict valueForKey:@"pm25"] intValue];
        self->_so2 = [(NSNumber*)[dict valueForKey:@"so2"] intValue];
    }
    return self;
}

@end


@implementation Realtime

- (id)init:(NSDictionary*)dict {
//    NSDictionary* skycon_dict = @{
//        @"CLEAR_DAY": @"晴",
//        @"CLEAR_NIGHT": @"晴",
//        @"PARTLY_CLOUDY_DAY": @"多云",
//        @"PARTLY_CLOUDY_NIGHT": @"多云",
//        @"CLOUDY": @"阴",
//        @"LIGHT_HAZE": @"轻度雾霾",
//        @"MODERATE_HAZE": @"中度雾霾",
//        @"HEAVY_HAZE": @"重度雾霾",
//        @"LIGHT_RAIN": @"小雨",
//        @"MODERATE_RAIN": @"中雨",
//        @"HEAVY_RAIN": @"大雨",
//        @"STORM_RAIN": @"暴雨",
//        @"FOG": @"雾",
//        @"LIGHT_SNOW": @"小雪",
//        @"MODERATE_SNOW": @"中雪",
//        @"HEAVY_SNOW": @"大雪",
//        @"STORM_SNOW": @"暴雪",
//        @"DUST": @"浮尘",
//        @"SAND": @"沙尘",
//        @"WIND": @"大风"
//    };
    if (self = [super init]) {
        self->_airQuality = [[AirQuality alloc] init:[dict valueForKey:@"air_quality"]];
        self->_lifeIndex = [[LifeIndex alloc] init:[dict valueForKey:@"life_index"]];
        self->_skycon = [dict valueForKey:@"skycon"];
        self->_temperature = [(NSNumber*)[dict valueForKey:@"temperature"] doubleValue];
    }
    
    
    return self;
}

@end
