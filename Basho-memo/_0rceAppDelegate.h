//
//  _0rceAppDelegate.h
//  Basho-memo
//
//  Created by KoichiSAKURAI on 2014/03/04.
//  Copyright (c) 2014年 40rce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoViewController.h"

@class MemoViewController;

@interface _0rceAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) MemoViewController *memoViewController;
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
