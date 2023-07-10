//
//  CYWeatherAll.h
//  WeatherForecast
//
//  Created by ByteDance on 2023/7/10.
//

#ifndef CYWeatherAll_h
#define CYWeatherAll_h

#import "DataModelBase.h"
#import "Realtime.h"
#import "Daily.h"


@interface CYWeatherAlertItem : DataModelBase

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSNumber *pubtimestamp;

@end

@interface CYWeatherAlert : DataModelBase

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSArray<CYWeatherAlertItem*> *content;

@end

@interface CYWeatherAllData : DataModelBase

@property (nonatomic, strong) CYWeatherAlert *alert;
@property (nonatomic, strong) Realtime *realtime;
@property (nonatomic, strong) Daily *daily;

@end


#endif /* CYWeatherAll_h */
