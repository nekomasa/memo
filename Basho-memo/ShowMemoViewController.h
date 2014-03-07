//
//  ShowMemoViewController.h
//  Basho-memo
//
//  Created by KoichiSAKURAI on 2014/03/05.
//  Copyright (c) 2014年 40rce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "_0rceAppDelegate.h"

@interface ShowMemoViewController : UIViewController <MKAnnotation,UITextFieldDelegate, UIGestureRecognizerDelegate,  CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *ShowMemoMap;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *datetimeLabel;
@property (strong, nonatomic) IBOutlet UIView *topLabelView;
@property (strong, nonatomic) IBOutlet UITextView *memoUIText;
@property (strong,nonatomic) NSArray *memoDetail;
@end
