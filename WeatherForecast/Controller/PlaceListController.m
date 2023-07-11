//
//  PlaceListController.m
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/17.
//

#import "PlaceListController.h"
#import "CYWeather.h"
#import "AppDelegate.h"
#import "PlaceList.h"
#import "LocationStorage.h"
#import "SceneDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import <Masonry/Masonry.h>

@interface PlaceListController () <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, copy) NSString *inputContent;
@property (strong, nonatomic) UITableView *places_tbl_view;
@property (nonatomic) dispatch_source_t timer;

@property (strong, nonatomic) UIView *view_container;


@end

@implementation PlaceListController {
    PlaceList* places;
    LocationStorage *storage;
}

static NSString *placeItemCellID = @"place_item_cellid";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    UITextField *placeInputField = [[UITextField alloc] init];
    [placeInputField setFont:[UIFont systemFontOfSize:18]];
    placeInputField.placeholder = @"请输入地点进行查询";
    [placeInputField addTarget:self action:@selector(place_changed:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:placeInputField];
    [placeInputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.leading.equalTo(self.view.mas_leading).with.offset(10);
        make.trailing.equalTo(self.view.mas_trailing).with.offset(-10);
        make.height.mas_equalTo(@20);
    }];
    self.places_tbl_view = [[UITableView alloc] init];
    [self.view addSubview:self.places_tbl_view];
    [self.places_tbl_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(placeInputField.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).with.offset(-10);
        make.leading.equalTo(self.view.mas_leading).with.offset(10);
        make.trailing.equalTo(self.view.mas_trailing).with.offset(-10);
    }];
    
    [self.places_tbl_view registerClass:[UITableViewCell class] forCellReuseIdentifier:placeItemCellID];
    self.places_tbl_view.delegate = self;
    self.places_tbl_view.dataSource = self;
    [self.places_tbl_view reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:placeItemCellID forIndexPath:indexPath];
    PlaceItem *item = [places.places objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [places.places count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlaceItem *place_info = [places.places objectAtIndex:indexPath.row];
    [LocationStorage saveLocation:place_info.name andLng:place_info.lng andLat:place_info.lat];
    
    [self dismissViewControllerAnimated:true completion:nil];
}


- (void)create_and_start_timer {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC), NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        [self cancel_timer];
        
        CYWeather *api = [[CYWeather alloc] init];
        [api searchPlaces:self.inputContent withHandler:^(PlaceList *places) {
            if (!places) return;
            
            self->places = places;
            NSLog(@"%@", self.inputContent);
            [self->_places_tbl_view reloadData];
        }];
    });
    dispatch_resume(self.timer);
}

- (void)cancel_timer {
    if (nil != self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

- (IBAction)place_changed:(UITextField *)sender {
    self.inputContent = sender.text;
    if (0 == self.inputContent.length) {
        return;
    }
    [self cancel_timer];
    [self create_and_start_timer];
}

@end
