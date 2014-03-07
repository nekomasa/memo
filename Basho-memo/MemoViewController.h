//
//  MemoViewController.h
//  Basho-log
//
//  Created by KoichiSAKURAI on 2014/02/12.
//  Copyright (c) 2014年 40rce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowMemoViewController.h"


@interface MemoViewController : UITableViewController
@property (nonatomic) NSArray *memoarrayobj;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic) NSMutableArray *memoarray;
@property  (nonatomic) NSManagedObjectContext *context;
@end
