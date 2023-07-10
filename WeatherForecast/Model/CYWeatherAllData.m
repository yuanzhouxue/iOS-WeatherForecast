//
//  CYWeatherAll.m
//  WeatherForecast
//
//  Created by ByteDance on 2023/7/10.
//

#import "CYWeatherAllData.h"


@implementation CYWeatherAlertItem

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.desc = value;
    }
}

@end

@implementation CYWeatherAlert

DECLARE_ARRAY_MEMBER(Content, content, CYWeatherAlertItem)

@end


@implementation CYWeatherAllData

DECLARE_OBJECT_MEMBER(Alert, alert, CYWeatherAlert)
DECLARE_OBJECT_MEMBER(Realtime, realtime, Realtime)
DECLARE_OBJECT_MEMBER(Daily, daily, Daily)

@end
