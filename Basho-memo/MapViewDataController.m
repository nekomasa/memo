//
//  MapViewDataController.m
//  Basho-log
//
//  Created by KoichiSAKURAI on 2014/02/15.
//  Copyright (c) 2014年 40rce. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MapViewDataController.h"
#import "MemoData.h"

@implementation MapViewDataController

-(NSString *)getReverseGeocodingLatitude:(float)latitude Longitude:(float)longitude
{
    //URLstringを生成
    NSString *str=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",latitude,longitude];
    //NSURLに変換
    NSURL *url =[NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //エラーの原因を知る為の変数
    NSError *jsonError;
    //サーバーから返ってきた値を、JSON型で格納する。
    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    NSDictionary *dict=[jsonData valueForKeyPath:@"results"][0];
    NSString *address = dict[@"formatted_address"];
    return address;
}
@end
