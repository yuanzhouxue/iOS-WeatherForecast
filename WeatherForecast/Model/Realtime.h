//
//  Realtime.h
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#ifndef Realtime_h
#define Realtime_h

#import <Foundation/Foundation.h>
#import "DataModelBase.h"

@interface LifeIndex : DataModelBase

@property (readonly, nonatomic) NSString *ultraviolet; // 紫外线
@property (readonly, nonatomic) NSString *comfort; // 舒适度指数

@end

@interface AirQualityData : DataModelBase

@property (readonly, nonatomic) NSNumber *chn;
@property (readonly, nonatomic) NSNumber *usa;

@end

@interface AirQualityDesc : DataModelBase

@property (readonly, nonatomic) NSString *chn;
@property (readonly, nonatomic) NSString *usa;

@end

@interface AirQuality : DataModelBase

@property (readonly, nonatomic) AirQualityData *aqi;
@property (readonly, nonatomic) AirQualityDesc *desc;
@property (readonly, nonatomic) NSNumber *co;
@property (readonly, nonatomic) NSNumber *no2;
@property (readonly, nonatomic) NSNumber *o3;
@property (readonly, nonatomic) NSNumber *pm10;
@property (readonly, nonatomic) NSNumber *pm25;
@property (readonly, nonatomic) NSNumber *so2;

@end

@interface Realtime : DataModelBase

@property (readonly, nonatomic) NSNumber *temperature;  // 气温
@property (readonly, nonatomic) NSString *skycon; // 天气现象
@property (readonly, nonatomic) LifeIndex *life_index; // 生活指数
@property (readonly, nonatomic) AirQuality *air_quality; // 空气指数

@end


#endif /* Realtime_h */
