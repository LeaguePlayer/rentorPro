//
//  VVAdvertisingsAndClientsViewController.m
//  rentor
//
//  Created by vegera on 25.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVAdvertisingsAndClientsViewController.h"
#import "VVMainAdvTableViewCell.h"

#import "VVServerManager.h"

@interface VVAdvertisingsAndClientsViewController ()

@property (strong, nonatomic) NSMutableArray* realtyArray;
@property (strong, nonatomic) NSMutableArray* clientArray;

@end

@implementation VVAdvertisingsAndClientsViewController

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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellRealtyIdentifier = @"MainAdvTableViewCell";
    
    
    VVMainAdvTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellRealtyIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[VVMainAdvTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellRealtyIdentifier andDictionary:@{@"123": @"123"}];
    }
    
    return cell;
}

#pragma mark - API

- (void)getTopicsFromServer {
    
    [[VVServerManager sharedManager]getTopicsGroup:self.group.group_id count:50 offset:[self.topicsArray count] onSuccess:^(NSArray *topicsGroupArray) {
        
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
        
    }];
}

@end
