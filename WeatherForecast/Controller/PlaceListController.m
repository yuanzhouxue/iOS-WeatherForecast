//
//  PlaceListController.m
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/17.
//

#import "PlaceListController.h"
#import "CYWeather.h"
#import "AppDelegate.h"
#import "WeatherForecast+CoreDataModel.h"
#import "PlaceList.h"
#import "LocationStorage.h"
#import "SceneDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface PlaceListController () <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *places_tbl_view;

@property (weak, nonatomic) IBOutlet UIView *view_container;

@end

@implementation PlaceListController {
    PlaceList* places;
    LocationStorage *storage;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage* bg_img = [UIImage imageNamed:@"bg_place"];
    UIColor* bg_color = [UIColor colorWithPatternImage:bg_img];
    self.view_container.backgroundColor = bg_color;
    
    _places_tbl_view.dataSource = self;
    _places_tbl_view.delegate = self;
    [_places_tbl_view reloadData];

    storage = [LocationStorage sharedInstance];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"place_item" forIndexPath:indexPath];
    PlaceItem *item = [places.places objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [places.places count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlaceItem *place_info = [places.places objectAtIndex:indexPath.row];
    [self saveLocation:place_info.name andLng:[place_info.lng doubleValue] andLat:[place_info.lat doubleValue]];
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)saveLocation:(NSString*)name andLng:(double)lng andLat:(double)lat {
//    Location *saved_loc = [storage getSavedLocation];
    [storage saveLocation:name andLng:lng andLat:lat];
}


- (IBAction)place_changed:(UITextField *)sender {
    NSLog(@"%@", sender.text);
    
    CYWeather *api = [[CYWeather alloc] init];
    [api searchPlaces:sender.text withHandler:^(PlaceList *places) {
        if (!places) return;
        
        self->places = places;
        [self->_places_tbl_view reloadData];
    }];
}



@end
