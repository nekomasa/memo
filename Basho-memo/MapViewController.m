//
//  MapViewController.m
//  Basho-log
//
//  Created by KoichiSAKURAI on 2014/02/14.
//  Copyright (c) 2014年 40rce. All rights reserved.
//

#import "MapViewController.h"
#import "MapViewDataController.h"
#import "MemoData.h"
#import "_0rceAppDelegate.h"


@interface MapViewController ()
@property(nonatomic, strong) UITapGestureRecognizer *singleTap;
@end

@implementation MapViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    self.mapview.showsUserLocation = YES;//現在地の情報を受け取る
    self.mapview.delegate = self;//デリゲートを設定
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //シングルタップのときの動作を指定
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    
    //PresentLocationLabelの背景色処理
    self.presentLocationLabelBackground.opaque = false;//半透明を許可
    UIColor *color = [UIColor darkGrayColor];//グレー
    UIColor *alphaColor = [color colorWithAlphaComponent:0.5]; //グレーの透過率
    self.presentLocationLabelBackground.backgroundColor = alphaColor;
    
    ///現在地を取得
    _latitude=0.0;
    _longitude=0.0;
    // ロケーションマネージャーを作成
	BOOL locationServicesEnabled;
	locationManager = [[CLLocationManager alloc] init];
	if ([CLLocationManager respondsToSelector:@selector(locationServicesEnabled)]) {
		// iOS4.0以降はクラスメソッドを使用
		locationServicesEnabled = [CLLocationManager locationServicesEnabled];
	} else {
		// iOS4.0以前はプロパティを使用
		locationServicesEnabled = locationManager.locationServicesEnabled;
	}
	if (locationServicesEnabled) {
		locationManager.delegate = self;
        // 位置情報取得開始
		[locationManager startUpdatingLocation];
	}
    
    
    
}

// 位置情報が取得成功した場合にコールされる
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	// 位置情報更新
    MapViewDataController *mvdc=[[MapViewDataController alloc]init];
	_longitude = newLocation.coordinate.longitude;
	_latitude = newLocation.coordinate.latitude;
    _address=[mvdc getReverseGeocodingLatitude:_latitude Longitude:_longitude];
    self.presentLocationLabel.text=_address;
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    CLLocationCoordinate2D centerCoordinate = newLocation.coordinate;
    MKCoordinateRegion coordinateRegion =
    MKCoordinateRegionMake(centerCoordinate, span);
    [self.mapview setRegion:coordinateRegion animated:YES];
    
}

// 位置情報が取得失敗した場合にコールされる。
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	if (error) {
		NSString* message = nil;
		switch ([error code]) {
                // アプリでの位置情報サービスが許可されていない場合
			case kCLErrorDenied:
				// 位置情報取得停止
				[locationManager stopUpdatingLocation];
				message = [NSString stringWithFormat:@"このアプリは位置情報サービスが許可されていません。"];
				break;
			default:
				message = [NSString stringWithFormat:@"位置情報の取得に失敗しました。"];
				break;
		}
		if (message) {
			// アラートを表示
			UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil
                                                 cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
		}
	}
}

//追加ボタンが押されときの処理
- (IBAction)addMemoBtnTouchDown:(id)sender {
    MemoData *myMemo =[[MemoData alloc]init];//メモ保存用インスタン
    myMemo.latitude =[[NSNumber alloc] initWithDouble:_latitude];//緯度
    myMemo.longitude=[[NSNumber alloc] initWithDouble:_longitude];//軽度
    myMemo.memo =self.memoText.text;
    myMemo.isSharePublic = [[NSNumber alloc] initWithInt:1];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];
    myMemo.dateTime = dateString;
    myMemo.address = _address;

    _0rceAppDelegate *appDelegate =
     [[UIApplication sharedApplication] delegate];

    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newMemo;
    newMemo = [NSEntityDescription insertNewObjectForEntityForName:@"Memo" inManagedObjectContext:context];
    NSString *a=myMemo.memo;
    [newMemo setValue:myMemo.dateTime forKey:@"dateTime"];
    [newMemo setValue:myMemo.isSharePublic forKey:@"isSharePublic"];
    [newMemo setValue:myMemo.latitude forKey:@"latitude"];
    [newMemo setValue:myMemo.longitude forKey:@"longitude"];
    [newMemo setValue:a forKey:@"memo"];
    [newMemo setValue:myMemo.address forKey:@"address"];
    NSError *error;
    [context save:&error];
    
    
    //ポップアップアラート
    UIAlertView *alert =
    [[UIAlertView alloc]initWithTitle:nil message:@"メモを追加しました" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

//テキストフィールドの外をタップでキーボード無効
-(void)onSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.memoText resignFirstResponder];
}

//キーボードを表示していない時は、他のジェスチャに影響を与えないように無効化しておく。
-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.singleTap) {
        // キーボード表示中のみ有効
        if (self.memoText.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

//アプリケーションのDocumentsディレクトリへのパスを返すni
- (NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
