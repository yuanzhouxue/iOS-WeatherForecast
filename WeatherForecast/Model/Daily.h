//
//  Daily.h
//  starter_demo
//
//  Created by 薛元洲 on 2023/5/1.
//

#ifndef Daily_h
#define Daily_h

@interface LifeIndexDailyItem : NSObject

@property (readonly, nonatomic) NSString *date;
@property (readonly, nonatomic) NSString *desc;
@property (readonly, nonatomic) int index;

- (id)init:(NSDictionary*)dict;

@end

@interface SkyconDailyItem : NSObject

@property (readonly, nonatomic) NSString *date;
@property (readonly, nonatomic) NSString *value;

- (id)init:(NSDictionary*)dict;

@end

@interface TemperatureDailyItem : NSObject

@property (readonly, nonatomic) double avg;
@property (readonly, nonatomic) NSString *date;
@property (readonly, nonatomic) double max;
@property (readonly, nonatomic) double min;

- (id)init:(NSDictionary*)dict;

@end

@interface Daily : NSObject

@property (readonly, nonatomic) NSArray *temperature;
@property (readonly, nonatomic) NSArray *skycon;
@property (readonly, nonatomic) NSArray *carWashing;
@property (readonly, nonatomic) NSArray *coldRisk;
@property (readonly, nonatomic) NSArray *comfort;
@property (readonly, nonatomic) NSArray *dressing;



- (id)init:(NSDictionary*)dict;

@end


#endif /* Daily_h */
