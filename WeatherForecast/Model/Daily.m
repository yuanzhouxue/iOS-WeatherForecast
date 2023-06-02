//
//  Daily.m
//  starter_demo
//
//  Created by 薛元洲 on 2023/5/1.
//

#import <Foundation/Foundation.h>
#import "Daily.h"

@implementation LifeIndexDailyItem

- (id)init:(NSDictionary*)dict {
    if (self = [super init]) {
        self->_desc = [dict valueForKey:@"desc"];
        self->_date = [dict valueForKey:@"date"];
        self->_index = [(NSNumber*)[dict valueForKey:@"index"] intValue];
    }
    return self;
}

@end

@implementation TemperatureDailyItem

- (id)init:(NSDictionary*)dict {
    if (self = [super init]) {
        self->_date = [dict valueForKey:@"date"];
        self->_avg = [(NSNumber*)[dict valueForKey:@"avg"] doubleValue];
        self->_min = [(NSNumber*)[dict valueForKey:@"min"] doubleValue];
        self->_max = [(NSNumber*)[dict valueForKey:@"max"] doubleValue];
    }
    return self;
}

@end

@implementation SkyconDailyItem

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
        self->_date = [dict valueForKey:@"date"];
        self->_value = [dict valueForKey:@"value"];
//        self->_value = [skycon_dict valueForKey:self->_value];
    }
    return self;
}

@end


@implementation Daily

- (id)init:(NSDictionary*)dict {
    if (self = [super init]) {
        NSArray *dict_temperature = [dict valueForKey:@"temperature"];
        NSMutableArray *temp =[[NSMutableArray alloc] initWithCapacity:dict_temperature.count];
        [dict_temperature enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            temp[idx] = [[TemperatureDailyItem alloc] init:obj];
        }];
        self->_temperature = temp;
        
        NSMutableArray *skycon_list = [[NSMutableArray alloc] initWithCapacity:dict_temperature.count];
        [(NSArray*)[dict valueForKey:@"skycon"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            skycon_list[idx] = [[SkyconDailyItem alloc] init:obj];
        }];
        self->_skycon = skycon_list;
        
        NSDictionary *lifeIndexDaily = [dict valueForKey:@"life_index"];
        NSMutableArray *carWashing = [NSMutableArray new];
        NSMutableArray *coldRisk = [NSMutableArray new];
        NSMutableArray *comfort = [NSMutableArray new];
        NSMutableArray *dressing = [NSMutableArray new];
        [(NSArray*)[lifeIndexDaily valueForKey:@"carWashing"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [carWashing addObject:[[LifeIndexDailyItem alloc] init:obj]];
        }];
        self->_carWashing = carWashing;
        [(NSArray*)[lifeIndexDaily valueForKey:@"coldRisk"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [coldRisk addObject:[[LifeIndexDailyItem alloc] init:obj]];
        }];
        self->_coldRisk = coldRisk;
        [(NSArray*)[lifeIndexDaily valueForKey:@"comfort"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [comfort addObject:[[LifeIndexDailyItem alloc] init:obj]];
        }];
        self->_comfort = comfort;
        [(NSArray*)[lifeIndexDaily valueForKey:@"dressing"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [dressing addObject:[[LifeIndexDailyItem alloc] init:obj]];
        }];
        self->_dressing = dressing;
    }
    return self;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"temps: %@, skycons: %@", self.temperature, self.skycon];
}

@end
