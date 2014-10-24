//
//  VVAdvTableViewController.m
//  rentor
//
//  Created by vegera on 01.08.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVAdvTableViewController.h"
#import "VVMainAdvTableViewCell.h"

@interface VVAdvTableViewController ()

@property (strong, nonatomic) NSArray* advArray;

@end

@implementation VVAdvTableViewController

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"prepareForSegue");
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;// [self.advArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellRealtyIdentifier = @"MainAdvTableViewCell";
    
    VVMainAdvTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellRealtyIdentifier];
    
    if (!cell) {
        cell = [[VVMainAdvTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellRealtyIdentifier];
        NSLog(@"create cell");
    } else {
        NSLog(@"reuse cell");
    }
    
    cell.countRoomLabel.text = @"4";
    cell.titleLabel.text = @"Беляевский район, окраина за 9 000 руб";
    cell.roomLabel.text = @"комнаты";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
    [self performSegueWithIdentifier:@"detailAdvSegue" sender:@{@"testKey": @"testObject"}];
}

#pragma mark - Actions

- (IBAction)menuButtonTapped:(id)sender
{
//    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

#pragma mark - API

- (void)getAdvFromServer {
    
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



@end
