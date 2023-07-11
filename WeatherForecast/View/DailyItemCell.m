//
//  DailyItemView.m
//  WeatherForecast
//
//  Created by ByteDance on 2023/7/11.
//

#import "DailyItemCell.h"
#import <Masonry.h>


@interface DailyItemCell ()

@end


@implementation DailyItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.date = [[UILabel alloc] init];
    self.date.font = [UIFont systemFontOfSize:17];
    self.date.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.date];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(4);
        make.bottom.equalTo(self.contentView).with.offset(-4);
        make.width.equalTo(@120);
    }];
    
    self.icon = [[UIImageView alloc] init];
    self.icon.image = [UIImage imageNamed:@"edit"];
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@20);
        make.leading.equalTo(self.date.mas_trailing);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.weather = [[UILabel alloc] init];
    self.weather.font = [UIFont systemFontOfSize:17];
    self.weather.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.weather];
    [self.weather mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.icon.mas_trailing).with.offset(8);
        make.top.equalTo(self.contentView).with.offset(4);
        make.bottom.equalTo(self.contentView).with.offset(-4);
    }];
    
    self.temp = [[UILabel alloc] init];
    self.temp.font = [UIFont systemFontOfSize:17];
    self.temp.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.temp];
    [self.temp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).with.offset(-8);
        make.top.equalTo(self.contentView).with.offset(4);
        make.bottom.equalTo(self.contentView).with.offset(-4);
    }];
    
}

@end
