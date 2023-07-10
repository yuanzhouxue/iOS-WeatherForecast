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

@property (strong, nonatomic) NSString *ultraviolet; // 紫外线
@property (strong, nonatomic) NSString *dressing; // 穿衣指数
@property (strong, nonatomic) NSString *comfort; // 舒适度指数
@property (strong, nonatomic) NSString *coldRisk; // 感冒指数
@property (strong, nonatomic) NSString *carWashing; // 洗车指数

@end

@interface AirQualityData : DataModelBase

@property (strong, nonatomic) NSNumber *chn;
@property (strong, nonatomic) NSNumber *usa;

@end

@interface AirQualityDesc : DataModelBase

@property (strong, nonatomic) NSString *chn;
@property (strong, nonatomic) NSString *usa;

@end

@interface AirQuality : DataModelBase

@property (strong, nonatomic) AirQualityData *aqi;
@property (strong, nonatomic) AirQualityDesc *desc;
@property (strong, nonatomic) NSNumber *co;
@property (strong, nonatomic) NSNumber *no2;
@property (strong, nonatomic) NSNumber *o3;
@property (strong, nonatomic) NSNumber *pm10;
@property (strong, nonatomic) NSNumber *pm25;
@property (strong, nonatomic) NSNumber *so2;

@end

@interface Realtime : DataModelBase

@property (strong, nonatomic) NSNumber *temperature;  // 气温
@property (strong, nonatomic) NSString *skycon; // 天气现象
@property (strong, nonatomic) LifeIndex *life_index; // 生活指数
@property (strong, nonatomic) AirQuality *air_quality; // 空气指数

@end


#endif /* Realtime_h */
