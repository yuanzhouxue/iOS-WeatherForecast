//
//  Realtime.m
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#import "Realtime.h"

@implementation LifeIndex

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    self->_ultraviolet = [(NSDictionary*)dict[@"ultraviolet"] valueForKey:@"desc"];
    self->_comfort = [(NSDictionary*)dict[@"comfort"] valueForKey:@"desc"];
    return self;
}

@end

@implementation AirQualityData

@end

@implementation AirQualityDesc

@end

@implementation AirQuality

DECLARE_OBJECT_MEMBER(Aqi, aqi, AirQualityData)

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self->_desc = [[AirQualityDesc alloc] initWithDictionary:value];
    }
}

@end


@implementation Realtime

DECLARE_OBJECT_MEMBER(Life_index, life_index, LifeIndex)
DECLARE_OBJECT_MEMBER(Air_quality, air_quality, AirQuality)

@end
