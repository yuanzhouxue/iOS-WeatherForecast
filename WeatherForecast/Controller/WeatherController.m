//
//  WeatherController.m
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/17.
//

#import "WeatherController.h"
#import "LocationStorage.h"
#import "CYWeather.h"
#import "PlaceListController.h"
#import "SceneDelegate.h"
#import <CoreLocation/CoreLocation.h>

#import "CYWeatherAllData.h"

@interface WeatherController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *location_label;
@property (weak, nonatomic) IBOutlet UILabel *temperature_label;
@property (weak, nonatomic) IBOutlet UILabel *aqi_label;

@property (weak, nonatomic) IBOutlet UILabel *daily_date_1;
@property (weak, nonatomic) IBOutlet UILabel *daily_date_2;
@property (weak, nonatomic) IBOutlet UILabel *daily_date_3;
@property (weak, nonatomic) IBOutlet UILabel *daily_date_4;
@property (weak, nonatomic) IBOutlet UILabel *daily_date_5;

@property (weak, nonatomic) IBOutlet UILabel *daily_weather_1;
@property (weak, nonatomic) IBOutlet UILabel *daily_weather_2;
@property (weak, nonatomic) IBOutlet UILabel *daily_weather_3;
@property (weak, nonatomic) IBOutlet UILabel *daily_weather_4;
@property (weak, nonatomic) IBOutlet UILabel *daily_weather_5;

@property (weak, nonatomic) IBOutlet UILabel *daily_temp_1;
@property (weak, nonatomic) IBOutlet UILabel *daily_temp_2;
@property (weak, nonatomic) IBOutlet UILabel *daily_temp_3;
@property (weak, nonatomic) IBOutlet UILabel *daily_temp_4;
@property (weak, nonatomic) IBOutlet UILabel *daily_temp_5;

@property (weak, nonatomic) IBOutlet UILabel *desc_coldrisk;
@property (weak, nonatomic) IBOutlet UILabel *desc_dressing;
@property (weak, nonatomic) IBOutlet UILabel *desc_ultraviolet;
@property (weak, nonatomic) IBOutlet UILabel *desc_carwashing;

@property (weak, nonatomic) IBOutlet UIView *view_realtime_bg;

@property (weak, nonatomic) IBOutlet UIImageView *img_daily_1;
@property (weak, nonatomic) IBOutlet UIImageView *img_daily_2;
@property (weak, nonatomic) IBOutlet UIImageView *img_daily_3;
@property (weak, nonatomic) IBOutlet UIImageView *img_daily_4;
@property (weak, nonatomic) IBOutlet UIImageView *img_daily_5;

@property (weak, nonatomic) IBOutlet UIImageView *icon_locate;
@property (weak, nonatomic) IBOutlet UIImageView *icon_menu;


@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) CLGeocoder* geoCoder;

@end

@implementation WeatherController {
    LocationStorage *storage;
    CYWeather *api;
    Daily *daily_weather;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconLocateClicked)];
    self.icon_locate.userInteractionEnabled = YES;
    [self.icon_locate addGestureRecognizer:tapGestureRecognizer];
    UITapGestureRecognizer* iconMenuGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconMenuClicked)];
    self.icon_locate.userInteractionEnabled = YES;
    [self.icon_menu addGestureRecognizer:iconMenuGestureRecognizer];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.geoCoder = [[CLGeocoder alloc] init];
    
    self->storage = [LocationStorage sharedInstance];
    self->api = [[CYWeather alloc] init];
    
    [self updateWeather];
}

- (void)iconLocateClicked {
    [self.locationManager startUpdatingLocation];
    NSLog(@"Locate clicked");
}

- (void)iconMenuClicked {
    [self selectLocation];
}

- (void)selectLocation {
    UIViewController *controller =  [self.storyboard instantiateViewControllerWithIdentifier:@"placelist_vc"];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:controller animated:true completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateWeather];
}

- (void)updateWeather {
    Location *saved_loc = [storage getSavedLocation];
    
    if (!saved_loc) {
        [self.locationManager startUpdatingLocation];
        return;
    }
    NSLog(@"加载天气信息：%@ at %f and %f", saved_loc.name, saved_loc.lng, saved_loc.lat);
    _location_label.text = saved_loc.name;
    [api all:saved_loc.lng andLat:saved_loc.lat andHandler:^(CYWeatherAllData *res) {
        NSLog(@"%@", res);
        [self updateRealtimeWeather:res.realtime];
        [self updateDailyWeather:res.daily];
    }];
//    [api realtimeLng:saved_loc.lng andLat:saved_loc.lat andHandler:^(Realtime *res) {
//        [self updateRealtimeWeather:res];
//    }];
//    [api dailyLng:saved_loc.lng andLat:saved_loc.lat andHandler:^(Daily *res) {
//        [self updateDailyWeather:res];
//    }];
}

- (void)updateRealtimeWeather:(Realtime*)realtime {
    Sky* sky = [CYWeather getSky:realtime.skycon];
    
    self.temperature_label.text = [NSString stringWithFormat:@"%.1f °C", [realtime.temperature doubleValue]];
    NSString *aqi_text = [NSString stringWithFormat:@"%@ | 空气指数 %d | %@", sky.desc, [realtime.air_quality.aqi.chn intValue], realtime.air_quality.desc.chn];
    self.aqi_label.text = aqi_text;
//    self.desc_ultraviolet.text = realtime.life_index.ultraviolet;
    
    UIImage* bg_img = [UIImage imageNamed:sky.bg_image];
    UIColor* background = [UIColor colorWithPatternImage:bg_img];
    self.view_realtime_bg.backgroundColor = background;
}

- (void)updateDailyWeather:(Daily*)daily {
    NSArray* daily_date = @[
        self.daily_date_1, self.daily_date_2, self.daily_date_3, self.daily_date_4, self.daily_date_5
    ];
    NSArray* daily_weather = @[
        self.daily_weather_1, self.daily_weather_2, self.daily_weather_3, self.daily_weather_4, self.daily_weather_5
    ];
    NSArray* daily_temperature = @[
        self.daily_temp_1, self.daily_temp_2, self.daily_temp_3, self.daily_temp_4, self.daily_temp_5
    ];
    NSArray* daily_icon = @[
        self.img_daily_1, self.img_daily_2, self.img_daily_3, self.img_daily_4, self.img_daily_5
    ];
    
    for (int i = 0; i < daily_temperature.count; ++i) {
        TemperatureDailyItem* tempItem = daily.temperature[i];
        SkyconDailyItem* skyconItem = daily.skycon[i];
        Sky* sky = [CYWeather getSky:skyconItem.value];
        
        ((UILabel*)daily_date[i]).text = [tempItem.date substringToIndex:10];
        ((UILabel*)daily_weather[i]).text = sky.desc;
        ((UILabel*)daily_temperature[i]).text = [NSString stringWithFormat:@"%.0f - %.0f °C", [tempItem.min doubleValue], [tempItem.max doubleValue]];
        
        ((UIImageView*)daily_icon[i]).image = [UIImage imageNamed:sky.ic_image];
    }
    
    self.desc_coldrisk.text = ((LifeIndexDailyItem*)daily.life_index.coldRisk[0]).desc;
    self.desc_dressing.text = ((LifeIndexDailyItem*)daily.life_index.dressing[0]).desc;
    self.desc_carwashing.text = ((LifeIndexDailyItem*)daily.life_index.carWashing[0]).desc;
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    CLAuthorizationStatus status = manager.authorizationStatus;
    if (status == kCLAuthorizationStatusNotDetermined) {
        return;
    }
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
//        [self.locationManager startUpdatingLocation];
    } else {
        [self selectLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation* location = locations.lastObject;
    [self dismissViewControllerAnimated:true completion:nil];
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark* placemark = [placemarks objectAtIndex:0];
            NSString* city = placemark.locality;
            if (!city) {
                city = placemark.administrativeArea;
            }
            
            NSLog(@"定位成功：%@", city);
            [self saveLocation:city andLng:location.coordinate.longitude andLat:location.coordinate.latitude];
            [self updateWeather];
        } else if (nil == error && [placemarks count] == 0) {
            NSLog(@"No results were returned.");
        } else {
            NSLog(@"An error occurred = %@", error);
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // 定位失败处理
    NSLog(@"定位失败: %@", error.localizedDescription);
}


- (void)saveLocation:(NSString*)name andLng:(double)lng andLat:(double)lat {
    [storage saveLocation:name andLng:lng andLat:lat];
}

@end
