//
//  VVNotificationViewController.m
//  rentor
//
//  Created by vegera on 01.08.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVNotificationViewController.h"
#import "VVMainAdvTableViewCell.h"

@interface VVNotificationViewController ()

@end

@implementation VVNotificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */

#pragma mark - API

- (void)getTopicsFromServer {
    
    /*[[VVServerManager sharedManager]getTopicsGroup:self.group.group_id count:50 offset:[self.topicsArray count] onSuccess:^(NSArray *topicsGroupArray) {
     
     if ([topicsGroupArray count] > 0) {
     
     [self.topicsArray addObjectsFromArray:topicsGroupArray];
     
     NSMutableArray* newPaths = [NSMutableArray array];
     for (int i = (int)[self.topicsArray count] - (int)[topicsGroupArray count]; i < [self.topicsArray count]; i++) {
     [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
     }
     
     [self.tableView beginUpdates];
     [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationNone];
     [self.tableView endUpdates];
     self.loadingData = NO;
     }
     
     
     } onFailure:^(NSError *error) {
     
     }];*/
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

/*- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor grayColor]];
    return headerView;
}*/

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"12323423423423";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellRealtyIdentifier = @"MainAdvTableViewCell";
    
    
    VVMainAdvTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellRealtyIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[VVMainAdvTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellRealtyIdentifier];
    }
    
    //    cell.countRoomLabel.text = @"4";
    //    cell.titleLabel.text = @"Центр, за 22 000 руб.";
    //    cell.roomLabel.text = @"комнаты";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
    [self performSegueWithIdentifier:@"detailAdvSegue" sender:@{@"testKey": @"testObject"}];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor colorWithRed:223.f/255.f green:223.f/255.f blue:223.f/255.f alpha:1.0];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    
    // Another way to set the background color
    // Note: does not preserve gradient effect of original header
    // header.contentView.backgroundColor = [UIColor blackColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28.f;
}

#pragma mark - Actions

- (IBAction)actionTab:(UISegmentedControl *)sender {
    if (self.tabSegmentedControl.selectedSegmentIndex == 0) {
        NSLog(@"actionTab: Недвижимость");
    }
    
    if (self.tabSegmentedControl.selectedSegmentIndex == 1) {
        NSLog(@"actionTab: Клиенты");
    }
}

- (IBAction)menuButtonTapped:(id)sender
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

@end
