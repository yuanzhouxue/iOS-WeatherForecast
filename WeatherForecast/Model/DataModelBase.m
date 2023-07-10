//
//  DataModelBase.m
//  WeatherForecast
//
//  Created by ByteDance on 2023/7/10.
//

#import "DataModelBase.h"
#import <objc/runtime.h>

@implementation DataModelBase

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *name = [NSString stringWithFormat:@"%s",property_getName(properties[i])];
        id value = [self valueForKey:name] ?:@"nil";
        [dict setObject:value forKey:name];
    }
    
    free(properties);
    return [NSString stringWithFormat:@"<%@:%p>:%@", [self class], self, dict];
}

@end
