//
//  LocationStorage.m
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#import <Foundation/Foundation.h>
#import "LocationStorage.h"
#import "AppDelegate.h"

@implementation Location

- (instancetype)initWithDIctionary:(NSDictionary*)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end

static NSString *location_key = @"location_key";

@implementation LocationStorage {
    
}


+ (Location*) getSavedLocation {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *savedLocationDictionary = (NSDictionary*)[userDefaults objectForKey:location_key];
    return [[Location alloc] initWithDIctionary:savedLocationDictionary];
}

+ (void) saveLocation:(NSString*)name andLng:(NSNumber*)lng andLat:(NSNumber*)lat {
    NSDictionary *location = @{
        @"name": name,
        @"lng": lng,
        @"lat": lat
    };
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:location forKey:location_key];
}

@end

