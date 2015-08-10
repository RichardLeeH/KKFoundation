//
//  LocationManager.m
//  KaKa
//
//  Created by lidechen on 15-3-26.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "LocationManager.h"
#import "Utils.h"

@interface LocationManager ()<CLLocationManagerDelegate>
{
}

@property(nonatomic,strong)CLLocationManager *location;

@end

@implementation LocationManager

+(LocationManager *) sharedInstance
{
    static LocationManager *_instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(void)startLocation
{
    //初始化位置管理器
    self.location = [[CLLocationManager alloc]init];
    //设置代理
    self.location.delegate = self;
    self.location.desiredAccuracy = kCLLocationAccuracyBest;
    //设置每隔100米更新位置
    self.location.distanceFilter = 100;
    
    if (IOS_VERSION_CODE >= 8.0)
    {
        [self.location requestWhenInUseAuthorization];
    }
    
    if ([CLLocationManager locationServicesEnabled])
    {
        //开始定位服务
        [self.location startUpdatingLocation];
    }
    else
    {
        CLLocationCoordinate2D ad ;
        ad.longitude = 0;
        ad.latitude = 0;
    }
}

//检测的是整个iOS系统的位置服务开关
+ (BOOL)locationEnable
{
    BOOL enable = [CLLocationManager locationServicesEnabled] &&  [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied;
    return (enable);
}

/**
 *  <#Description#>
 *
 *  @param aManager     <#aManager description#>
 *  @param aNewLocation <#aNewLocation description#>
 *  @param aOldLocation <#aOldLocation description#>
 */
-(void)locationManager:(CLLocationManager *)aManager
   didUpdateToLocation:(CLLocation *)aNewLocation
          fromLocation:(CLLocation *)aOldLocation
{
    CLLocationCoordinate2D a2d ;
    a2d.latitude  = aNewLocation.coordinate.latitude;
    a2d.longitude = aNewLocation.coordinate.longitude;
    
    self.coord = a2d;
    
    CLLocation *c = [[CLLocation alloc] initWithLatitude:a2d.latitude longitude:a2d.longitude];
    
    //创建位置
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:c
                 completionHandler:^(NSArray *placemarks, NSError *error)
    {
                     if (!error && [placemarks count] > 0)
                     {
                         CLPlacemark* mark = [placemarks objectAtIndex:0];
                         NSDictionary *dict = [mark addressDictionary];
                         NSString* locality = [dict objectForKey:@"State"];

                         NSLog(@"locality: %@,%@",locality,[dict objectForKey:@"SubLocality"]);
                         self.addressDict = dict;
                         
                         [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_CHANGED_NOTIFICATION object:nil];
                     }
                     else
                     {
                         self.addressDict = nil;
                         NSLog(@"ERROR: %@", error);
                     }
    }];
}

-(NSString*)getCurCity
{
    if (!isBlankObject(self.addressDict))
    {
        NSString *ret = [self.addressDict objectForKey:@"City"];
        if (isBlankString(ret))
        {
            ret = @"";
        }
        return ret;
    }
    return @"";
}

-(void)locationManager:(CLLocationManager *)manager
      didFailWithError:(NSError *)error
{
    CLLocationCoordinate2D a2d ;
    a2d.latitude = 0;
    a2d.longitude = 0;
    
    self.coord = a2d;
    
    switch([error code])
    {
        case kCLErrorDenied:
            //Access denied by user
            //Do something...
            break;
        case kCLErrorLocationUnknown:
            //Probably temporary...
            //Do something else...
            break;
        default:
            break;
    }
}

@end
