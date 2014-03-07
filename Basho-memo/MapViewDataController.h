//
//  MapViewDataController.h
//  Basho-log
//
//  Created by KoichiSAKURAI on 2014/02/15.
//  Copyright (c) 2014年 40rce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemoData.h"

@interface MapViewDataController : NSObject<UIApplicationDelegate, NSXMLParserDelegate>
@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) NSMutableArray *address;
-(NSString *)getReverseGeocodingLatitude:(float)latitude Longitude:(float)longitude;
@end
