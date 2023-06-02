//
//  LocationStorage.m
//  starter_demo
//
//  Created by 薛元洲 on 2023/3/19.
//

#import <Foundation/Foundation.h>
#import "LocationStorage.h"
#import "AppDelegate.h"

@implementation LocationStorage {
    NSPersistentContainer *container;
    Location *cache;
}

static LocationStorage* __sharedInstance = nil;

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[super allocWithZone:NULL] init];
    });
    return __sharedInstance;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [LocationStorage sharedInstance] ;
}
 
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [LocationStorage sharedInstance] ;
}

- (id) init {
    self = [super init];
    if (self) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        container = delegate.persistentContainer;
        
        cache = nil;
    }
    return self;
}

- (Location*) getSavedLocation {
    // ++++++++ 查询数据 ++++++++
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要查询的实体：
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:container.viewContext];
    request.entity = entity;
    NSError *error = nil;
    NSArray *objs = [container.viewContext executeFetchRequest:request error:&error];
    if (objs.count == 1) cache = objs[0];
    else NSLog(@"%lu", objs.count);
    return cache;
}

- (void) saveLocation:(NSString*)name andLng:(double)lng andLat:(double)lat {
    if (!cache) {
        cache = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:container.viewContext];
    }
    cache.name = name;
    cache.lng = lng;
    cache.lat = lat;
    
    NSError *error = nil;
    [container.viewContext save:&error];
}

@end

