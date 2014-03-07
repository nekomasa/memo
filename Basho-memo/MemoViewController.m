//
//  MemoViewController.m
//  Basho-log
//
//  Created by KoichiSAKURAI on 2014/02/12.
//  Copyright (c) 2014年 40rce. All rights reserved.
//

#import "MemoViewController.h"
#import "MemoTableViewCell.h"
#import "MemoData.h"
#import <CoreData/CoreData.h>
#import "_0rceAppDelegate.h"
#import "ShowMemoViewController.h"

@interface MemoViewController ()

@end

@implementation MemoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    _0rceAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    self.editButton = self.editButtonItem;
    _context = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Memo" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.memoarrayobj = [_context executeFetchRequest:fetchRequest error:&error];
    self.title = @"Memo";
    self.memoarray = [NSMutableArray array];
    
    for (NSManagedObject *mo in self.memoarrayobj) {
        NSMutableArray *memo=[NSMutableArray array];
        [memo addObject:[mo valueForKey:@"address"]];
        [memo addObject:[mo valueForKey:@"dateTime"]];
        [memo addObject:[mo valueForKey:@"latitude"]];
        [memo addObject:[mo valueForKey:@"longitude"]];
        [memo addObject:[mo valueForKey:@"memo"]];
        [memo addObject:[mo valueForKey:@"isSharePublic"]];
        NSLog(@"%@",memo[0]);
        NSLog(@"%@",memo[1]);
        NSLog(@"%@",memo[2]);
        NSLog(@"%@",memo[3]);
        NSLog(@"%@",memo[4]);
        NSLog(@"%@",memo[5]);
        [_memoarray addObject:memo];
    }
    
    [self.tableView reloadData];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"テーブル設定のテスト";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

// 行はすべて編集可能にする
-(BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.memoarray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MemoCell";
    MemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MemoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //configure the cell...
    int row = [indexPath row];
    cell.MemoLabel.text=_memoarray[row][4];
    cell.addressLabel.text =_memoarray[row][0];
    cell.DatetimeLabel.text =_memoarray[row][1];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

 // Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
     [_memoarray removeObjectAtIndex:indexPath.row];
     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     [_context deleteObject:_memoarrayobj[indexPath.row]];
     NSError *error = nil;
     if (![_context save:&error]) {
         NSLog(@"error = %@", error);
         
     } else {
         NSLog(@"Save Completed.");
     }
     }
 /*else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }*/
     
 }

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if([[segue identifier] isEqualToString:@"ShowMemoDetail"]){
         ShowMemoViewController *showmemoviewcontroller =
         [segue destinationViewController];
         NSIndexPath *myIndexPath =[self.tableView indexPathForSelectedRow];
         int row = [myIndexPath row];
         showmemoviewcontroller.memoDetail=_memoarray[row];
     }
 
 }

@end
