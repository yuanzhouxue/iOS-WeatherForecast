//
//  LifeIndexCell.h
//  WeatherForecast
//
//  Created by ByteDance on 2023/7/11.
//

#ifndef LifeIndexCell_h
#define LifeIndexCell_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LifeIndexCell : UIView

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *desc;

@end

#endif /* LifeIndexCell_h */
