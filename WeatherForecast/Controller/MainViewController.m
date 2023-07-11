//
//  MainViewCOntroller.m
//  WeatherForecast
//
//  Created by ByteDance on 2023/7/11.
//

#import "MainViewController.h"
#import <Masonry.h>
#import <CoreLocation/CoreLocation.h>
#import "DailyItemCell.h"
#import "LifeIndexCell.h"
#import "Daily.h"
#import "CYWeather.h"
#import "LocationStorage.h"
#import "PlaceListController.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UILabel *temperatureLabel;
@property (strong, nonatomic) UILabel *aqiLabel;

@property (strong, nonatomic) LifeIndexCell *item_coldrisk;
@property (strong, nonatomic) LifeIndexCell *item_dressing;
@property (strong, nonatomic) LifeIndexCell *item_ultraviolet;
@property (strong, nonatomic) LifeIndexCell *item_carwashing;

@property (strong, nonatomic) UIView *realtimeContainer;

@property (strong, nonatomic) UIImageView *iconLocate;
@property (strong, nonatomic) UIImageView *iconMenu;


@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) CLGeocoder* geoCoder;

@property (nonatomic, strong) UITableView *dailyTableView;

@end


@implementation MainViewController {
    Daily *data;
    CYWeather *api;
}
static NSString *cellID = @"cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.geoCoder = [[CLGeocoder alloc] init];
    
    self->api = [[CYWeather alloc] init];
    [self updateWeather];
}

- (void)setupUI {
    
    self.realtimeContainer = [[UIView alloc] init];
    UIView *dailyContainer = [[UIView alloc] init];
    UIView *lifeIndexContainer = [[UIView alloc] init];
    
    [self.view addSubview:self.realtimeContainer];
    [self.view addSubview:dailyContainer];
    [self.view addSubview:lifeIndexContainer];
    
    [self.realtimeContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@(400));
    }];
    
    self.locationLabel = [[UILabel alloc] init];
    [self.realtimeContainer addSubview:self.locationLabel];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(300));
        make.height.equalTo(@(30));
        make.leading.equalTo(self.locationLabel.superview);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    }];
    self.locationLabel.font = [UIFont systemFontOfSize:20];
    self.locationLabel.textAlignment = NSTextAlignmentCenter;
    self.locationLabel.textColor = [UIColor whiteColor];
    
    self.iconMenu = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edit"]];
    self.iconLocate = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"locate"]];
    [self.realtimeContainer addSubview:self.iconMenu];
    [self.realtimeContainer addSubview:self.iconLocate];
    [self.iconMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@(30));
        make.top.equalTo(self.locationLabel);
        make.right.equalTo(self.realtimeContainer).with.offset(-10);
    }];
    [self.iconLocate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@(30));
        make.top.equalTo(self.locationLabel);
        make.right.equalTo(self.iconMenu.mas_left).with.offset(-10);
    }];
    self.iconMenu.userInteractionEnabled = YES;
    self.iconLocate.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconLocateClicked)];
    [self.iconLocate addGestureRecognizer:tapGestureRecognizer];
    UITapGestureRecognizer* iconMenuGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconMenuClicked)];
    [self.iconMenu addGestureRecognizer:iconMenuGestureRecognizer];
    
    
    self.aqiLabel = [[UILabel alloc] init];
    self.temperatureLabel = [[UILabel alloc] init];
    self.aqiLabel.textAlignment = NSTextAlignmentCenter;
    self.aqiLabel.font = [UIFont systemFontOfSize:20];
    self.aqiLabel.textColor = [UIColor whiteColor];
    self.temperatureLabel.textAlignment = NSTextAlignmentCenter;
    self.temperatureLabel.font = [UIFont systemFontOfSize:64];
    self.temperatureLabel.textColor = [UIColor whiteColor];
    [self.realtimeContainer addSubview:self.temperatureLabel];
    [self.realtimeContainer addSubview:self.aqiLabel];
    [self.temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationLabel.mas_bottom).with.offset(16);
        make.left.and.right.equalTo(self.realtimeContainer);
    }];
    [self.aqiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.temperatureLabel).with.offset(16);
        make.left.and.right.equalTo(self.realtimeContainer);
        make.bottom.equalTo(self.realtimeContainer);
    }];
    
    UILabel *dailyTitle = [[UILabel alloc] init];
    dailyTitle.text = @"未来天气";
    dailyTitle.textColor = [UIColor blackColor];
    dailyTitle.font = [UIFont systemFontOfSize:17];
    [lifeIndexContainer addSubview:dailyTitle];
    [dailyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dailyContainer).with.offset(4);
        make.leading.and.trailing.equalTo(dailyContainer);
    }];
    [dailyContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(16);
        make.trailing.equalTo(self.view).with.offset(-16);
        make.top.equalTo(self.realtimeContainer.mas_bottom).with.offset(8);
        make.height.equalTo(@200);
    }];
    self.dailyTableView = [[UITableView alloc] init];
    [self.dailyTableView registerClass:[DailyItemCell class] forCellReuseIdentifier:cellID];
    self.dailyTableView.delegate = self;
    self.dailyTableView.dataSource = self;
    [self.dailyTableView reloadData];
    
    [dailyContainer addSubview:self.dailyTableView];
    [self.dailyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(dailyContainer);
        make.top.equalTo(dailyTitle.mas_bottom).with.offset(8);
        make.bottom.equalTo(dailyContainer);
    }];
    
    [lifeIndexContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(16);
        make.trailing.equalTo(self.view).with.offset(-16);
        make.top.equalTo(dailyContainer.mas_bottom);
    }];
    UILabel *lifeIndexTitle = [[UILabel alloc] init];
    lifeIndexTitle.text = @"生活指数";
    lifeIndexTitle.textColor = [UIColor blackColor];
    lifeIndexTitle.font = [UIFont systemFontOfSize:17];
    [lifeIndexContainer addSubview:lifeIndexTitle];
    [lifeIndexTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lifeIndexContainer).with.offset(8);
        make.leading.and.trailing.equalTo(lifeIndexContainer);
    }];
    
    UIStackView *rowsStack = [[UIStackView alloc] init];
    rowsStack.axis = UILayoutConstraintAxisVertical;
    rowsStack.spacing = 8;
    [lifeIndexContainer addSubview:rowsStack];
    [rowsStack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lifeIndexTitle.mas_bottom).with.offset(8);
        make.leading.trailing.equalTo(lifeIndexContainer);
    }];
    
    UIStackView *firstRow = [[UIStackView alloc] init];
    firstRow.axis = UILayoutConstraintAxisHorizontal;
    self.item_coldrisk = [[LifeIndexCell alloc] init];
    self.item_coldrisk.icon.image = [UIImage imageNamed:@"ic_coldrisk"];
    self.item_coldrisk.title.text = @"感冒";
    [firstRow addArrangedSubview:self.item_coldrisk];
    [self.item_coldrisk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@60);
        make.width.equalTo(firstRow.mas_width).with.multipliedBy(0.5);
    }];
    self.item_dressing = [[LifeIndexCell alloc] init];
    self.item_dressing.icon.image = [UIImage imageNamed:@"ic_dressing"];
    self.item_dressing.title.text = @"穿衣";
    [firstRow addArrangedSubview:self.item_dressing];
    [self.item_dressing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@60);
        make.width.equalTo(firstRow.mas_width).with.multipliedBy(0.5);
    }];
    [rowsStack addArrangedSubview:firstRow];
    
    UIStackView *secondRow = [[UIStackView alloc] init];
    secondRow.axis = UILayoutConstraintAxisHorizontal;
    self.item_ultraviolet = [[LifeIndexCell alloc] init];
    self.item_ultraviolet.icon.image = [UIImage imageNamed:@"ic_ultraviolet"];
    self.item_ultraviolet.title.text = @"紫外线";
    [secondRow addArrangedSubview:self.item_ultraviolet];
    [self.item_ultraviolet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@60);
        make.width.equalTo(secondRow.mas_width).with.multipliedBy(0.5);
    }];
    self.item_carwashing = [[LifeIndexCell alloc] init];
    self.item_carwashing.icon.image = [UIImage imageNamed:@"ic_carwashing"];
    self.item_carwashing.title.text = @"洗车";
    [secondRow addArrangedSubview:self.item_carwashing];
    [self.item_carwashing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@60);
        make.width.equalTo(secondRow.mas_width).with.multipliedBy(0.5);
    }];
    [rowsStack addArrangedSubview:secondRow];
}

- (void)iconLocateClicked {
    [self.locationManager startUpdatingLocation];
}

- (void)iconMenuClicked {
    [self selectLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateWeather];
}

- (void)selectLocation {
    UIViewController *controller = [[PlaceListController alloc] init];
//    [self.storyboard instantiateViewControllerWithIdentifier:@"placelist_vc"];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:controller animated:true completion:nil];
}

- (void)updateWeather {
    Location *saved_loc = [LocationStorage getSavedLocation];
    
    if (!saved_loc) {
        [self.locationManager startUpdatingLocation];
        return;
    }
    NSLog(@"加载天气信息：%@ at %f and %f", saved_loc.name, [saved_loc.lng doubleValue], [saved_loc.lat doubleValue]);
    self.locationLabel.text = saved_loc.name;
    [api all:[saved_loc.lng doubleValue]
      andLat:[saved_loc.lat doubleValue]
  andHandler:^(CYWeatherAllData *res) {
        [self updateRealtimeWeather:res.realtime];
        [self updateDailyWeather:res.daily];
    }];
}

- (void)updateRealtimeWeather:(Realtime*)realtime {
    Sky* sky = [CYWeather getSky:realtime.skycon];
    
    self.temperatureLabel.text = [NSString stringWithFormat:@"%.1f °C", [realtime.temperature doubleValue]];
    NSString *aqi_text = [NSString stringWithFormat:@"%@ | 空气指数 %d | %@", sky.desc, [realtime.air_quality.aqi.chn intValue], realtime.air_quality.desc.chn];
    self.aqiLabel.text = aqi_text;
    self.item_ultraviolet.desc.text = realtime.life_index.ultraviolet;
    
    UIImage* bg_img = [UIImage imageNamed:sky.bg_image];
    UIColor* background = [UIColor colorWithPatternImage:bg_img];
    self.realtimeContainer.backgroundColor = background;
}

- (void)updateDailyWeather:(Daily*)daily {
    data = daily;
    [self.dailyTableView reloadData];
       
    self.item_coldrisk.desc.text = ((LifeIndexDailyItem*)daily.life_index.coldRisk[0]).desc;
    self.item_dressing.desc.text = ((LifeIndexDailyItem*)daily.life_index.dressing[0]).desc;
    self.item_carwashing.desc.text = ((LifeIndexDailyItem*)daily.life_index.carWashing[0]).desc;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DailyItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    TemperatureDailyItem* tempItem = data.temperature[indexPath.row];
    SkyconDailyItem* skyconItem = data.skycon[indexPath.row];
    Sky* sky = [CYWeather getSky:skyconItem.value];
    
    cell.date.text = [tempItem.date substringToIndex:10];
    cell.weather.text = sky.desc;
    cell.temp.text = [NSString stringWithFormat:@"%.0f - %.0f °C", [tempItem.min doubleValue], [tempItem.max doubleValue]];
    
    cell.icon.image = [UIImage imageNamed:sky.ic_image];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.skycon.count;
}


- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    CLAuthorizationStatus status = manager.authorizationStatus;
    if (status == kCLAuthorizationStatusNotDetermined) {
        return;
    }
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
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
            [self saveLocation:city
                        andLng:[NSNumber numberWithDouble:location.coordinate.longitude]
                        andLat:[NSNumber numberWithDouble:location.coordinate.latitude]];
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

- (void)saveLocation:(NSString*)name andLng:(NSNumber*)lng andLat:(NSNumber*)lat {
    [LocationStorage saveLocation:name andLng:lng andLat:lat];
}

@end
