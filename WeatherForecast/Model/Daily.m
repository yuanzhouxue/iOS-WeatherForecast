//
//  Daily.m
//  starter_demo
//
//  Created by 薛元洲 on 2023/5/1.
//

#import <Foundation/Foundation.h>
#import "Daily.h"

@implementation LifeIndexDailyItem

@end

@implementation TemperatureDailyItem


@end

@implementation SkyconDailyItem


@end

@implementation DailyLifeIndex

DECLARE_ARRAY_MEMBER(CarWashing, carWashing, LifeIndexDailyItem)
DECLARE_ARRAY_MEMBER(ColdRisk, coldRisk, LifeIndexDailyItem)
DECLARE_ARRAY_MEMBER(Comfort, comfort, LifeIndexDailyItem)
DECLARE_ARRAY_MEMBER(Dressing, dressing, LifeIndexDailyItem)

@end


@implementation Daily

DECLARE_ARRAY_MEMBER(Temperature, temperature, TemperatureDailyItem)
DECLARE_ARRAY_MEMBER(Skycon, skycon, SkyconDailyItem)
DECLARE_OBJECT_MEMBER(Life_index, life_index, DailyLifeIndex)

- (NSString*)description {
    return [NSString stringWithFormat:@"temps: %@, skycons: %@", self.temperature, self.skycon];
}

@end
