//
//  Realtime.h
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#ifndef Realtime_h
#define Realtime_h

#import <Foundation/Foundation.h>

@interface LifeIndex : NSObject

@property (readonly, nonatomic) NSString *ultraviolet; // 紫外线
@property (readonly, nonatomic) NSString *dressing; // 穿衣指数
@property (readonly, nonatomic) NSString *comfort; // 舒适度指数
@property (readonly, nonatomic) NSString *coldRisk; // 感冒指数
@property (readonly, nonatomic) NSString *carWashing; // 洗车指数

@end

@interface AirQuality : NSObject

@property (readonly, nonatomic) int aqi;
@property (readonly, nonatomic) NSString *desc;
@property (readonly, nonatomic) int co;
@property (readonly, nonatomic) int no2;
@property (readonly, nonatomic) int o3;
@property (readonly, nonatomic) int pm10;
@property (readonly, nonatomic) int pm25;
@property (readonly, nonatomic) int so2;

@end

@interface Realtime : NSObject

@property (readonly, nonatomic) double temperature;  // 气温
@property (readonly, nonatomic) NSString *skycon; // 天气现象
@property (readonly, nonatomic) LifeIndex *lifeIndex; // 生活指数
@property (readonly, nonatomic) AirQuality *airQuality; // 空气指数

- (id)init:(NSDictionary*)dict;

@end


#endif /* Realtime_h */
