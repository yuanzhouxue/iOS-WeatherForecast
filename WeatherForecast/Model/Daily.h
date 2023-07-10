//
//  Daily.h
//  starter_demo
//
//  Created by 薛元洲 on 2023/5/1.
//

#ifndef Daily_h
#define Daily_h

#import "DataModelBase.h"

@interface LifeIndexDailyItem : DataModelBase

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSNumber *index;

@end

@interface SkyconDailyItem : DataModelBase

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *value;

@end

@interface TemperatureDailyItem : DataModelBase

@property (strong, nonatomic) NSNumber *avg;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSNumber *max;
@property (strong, nonatomic) NSNumber *min;

@end

@interface DailyLifeIndex : DataModelBase

@property (strong, nonatomic) NSArray<LifeIndexDailyItem*> *carWashing;
@property (strong, nonatomic) NSArray<LifeIndexDailyItem*> *coldRisk;
@property (strong, nonatomic) NSArray<LifeIndexDailyItem*> *comfort;
@property (strong, nonatomic) NSArray<LifeIndexDailyItem*> *dressing;

@end

@interface Daily : DataModelBase

@property (strong, nonatomic) NSArray<TemperatureDailyItem*> *temperature;
@property (strong, nonatomic) NSArray<SkyconDailyItem*> *skycon;
@property (strong, nonatomic) DailyLifeIndex *life_index;


@end


#endif /* Daily_h */
