//
//  ShowMemoViewController.m
//  Basho-memo
//
//  Created by KoichiSAKURAI on 2014/03/05.
//  Copyright (c) 2014年 40rce. All rights reserved.
//

#import "ShowMemoViewController.h"
@interface ShowMemoViewController ()
@property(nonatomic, strong) UITapGestureRecognizer *singleTap;
@end

@implementation ShowMemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view
    _addressLabel.text=_memoDetail[0];
    _datetimeLabel.text=_memoDetail[1];
    _memoUIText.text =_memoDetail[4];
    
    self.ShowMemoMap.delegate = self;
    
    
    CLLocation *memoLocation =[[CLLocation alloc]initWithLatitude:(CLLocationDegrees)[_memoDetail[2] doubleValue] longitude:(CLLocationDegrees)[_memoDetail[3] doubleValue]];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    CLLocationCoordinate2D centerCoordinate = memoLocation.coordinate;
    MKCoordinateRegion coordinateRegion =
    MKCoordinateRegionMake(centerCoordinate, span);
    [self.ShowMemoMap setRegion:coordinateRegion animated:NO];
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
