//
//  Location.h
//  Basho-log
//
//  Created by KoichiSAKURAI on 2014/02/14.
//  Copyright (c) 2014年 40rce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (strong, nonatomic) NSString *address;

@property (strong, nonatomic) NSString *photoFileName;

@property (nonatomic) float latitude;

@property (nonatomic) float longitude;

@end
