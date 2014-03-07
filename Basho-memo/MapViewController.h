//
//  MapViewController.h
//  Basho-log
//
//  Created by KoichiSAKURAI on 2014/02/14.
//  Copyright (c) 2014年 40rce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MemoData.h"
#import "_0rceAppDelegate.h"

@interface MapViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate>{
    // ロケーションマネージャー
	CLLocationManager* locationManager;
	// 現在位置記録用
	CLLocationDegrees _longitude;
	CLLocationDegrees _latitude;
    NSString *_address;
    
}
@property (weak, nonatomic) IBOutlet UIView *presentLocationLabelBackground;
@property (weak, nonatomic) IBOutlet UILabel *presentLocationLabel;
@property (weak, nonatomic) IBOutlet UITextField *memoText;
@property (weak, nonatomic) IBOutlet UIButton *addMemoBtn;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@end
