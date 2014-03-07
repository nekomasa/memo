//
//  MemoTableViewCell.h
//  Basho-memo
//
//  Created by KoichiSAKURAI on 2014/03/04.
//  Copyright (c) 2014年 40rce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *MemoLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *DatetimeLabel;
@end
