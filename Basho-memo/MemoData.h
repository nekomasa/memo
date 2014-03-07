//
//  MemoData.h
//  Basho-log
//
//  Created by KoichiSAKURAI on 2014/02/26.
//  Copyright (c) 2014年 40rce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemoData : NSObject{
    
    NSString * _address;
    NSString * _dateTime;
    NSNumber * _isSharePublic;
    NSNumber * _latitude;
    NSNumber * _longitude;
    NSString * _memo;
}

@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * dateTime;
@property (nonatomic, copy) NSNumber * isSharePublic;
@property (nonatomic, copy) NSNumber * latitude;
@property (nonatomic, copy) NSNumber * longitude;
@property (nonatomic, copy) NSString * memo;
@end
