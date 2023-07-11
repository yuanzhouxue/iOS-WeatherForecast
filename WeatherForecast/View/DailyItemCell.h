//
//  DailyItemView.h
//  WeatherForecast
//
//  Created by ByteDance on 2023/7/11.
//

#ifndef DailyItemView_h
#define DailyItemView_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DailyItemCell : UITableViewCell

@property (nonatomic, strong) UILabel *date;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *weather;
@property (nonatomic, strong) UILabel *temp;

@end

#endif /* DailyItemView_h */
