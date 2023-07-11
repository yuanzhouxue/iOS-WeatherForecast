//
//  LifeIndexCell.m
//  WeatherForecast
//
//  Created by ByteDance on 2023/7/11.
//

#import "LifeIndexCell.h"
#import <Masonry.h>

@implementation LifeIndexCell

- (instancetype)init {
    if (self = [super init]) {
        self.icon = [[UIImageView alloc] init];
        self.title = [[UILabel alloc] init];
        self.title.font = [UIFont systemFontOfSize:13];
        self.title.textColor = [UIColor blackColor];
        self.desc = [[UILabel alloc] init];
        self.desc.font = [UIFont systemFontOfSize:17];
        self.desc.textColor = [UIColor blackColor];
        [self addSubview:self.icon];
        [self addSubview:self.title];
        [self addSubview:self.desc];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@30);
            make.top.leading.equalTo(self).with.offset(15);
        }];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@16);
            make.leading.equalTo(self.icon.mas_trailing).with.offset(16);
            make.top.equalTo(self);
            make.trailing.equalTo(self);
        }];
        [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.bottom.trailing.equalTo(self);
            make.leading.equalTo(self.icon.mas_trailing).with.offset(16);
        }];
    }
    return self;
}

@end
