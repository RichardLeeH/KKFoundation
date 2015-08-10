//
//  LocationManager.h
//  KaKa
//
//  Created by lidechen on 15-3-26.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define LOCATION_CHANGED_NOTIFICATION  @"LOCATION_CHANGED_NOTIFICATION"
#define kkSharedLocationManager [LocationManager sharedInstance]

@interface LocationManager : NSObject

@property(nonatomic)CLLocationCoordinate2D                  coord;
@property(nonatomic,strong)NSDictionary                     *addressDict;

+(LocationManager *) sharedInstance;
+ (BOOL)locationEnable;
-(void)startLocation;
-(NSString*)getCurCity;

@end
