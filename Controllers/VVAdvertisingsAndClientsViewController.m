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

#import "UIViewController+ECSlidingViewController.h"
#import "MEDynamicTransition.h"
#import "METransitions.h"

@interface VVAdvertisingsAndClientsViewController ()

@property (nonatomic, strong) METransitions *transitions;
@property (nonatomic, strong) UIPanGestureRecognizer *dynamicTransitionPanGesture;

@property (strong, nonatomic) NSMutableArray* realtyArray;
@property (strong, nonatomic) NSMutableArray* clientArray;

@end

@implementation VVAdvertisingsAndClientsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.tableView.clearsSelectionOnViewWillAppear = NO;
    
    self.transitions.dynamicTransition.slidingViewController = self.slidingViewController;
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSIndexPath *defaultIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [self.tableView selectRowAtIndexPath:defaultIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//    });
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    [self tableView:self.tableView didSelectRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
//}

#pragma mark - Properties

- (METransitions *)transitions {
    if (_transitions) return _transitions;
    
    _transitions = [[METransitions alloc] init];
    
    return _transitions;
}

- (UIPanGestureRecognizer *)dynamicTransitionPanGesture {
    if (_dynamicTransitionPanGesture) return _dynamicTransitionPanGesture;
    
    _dynamicTransitionPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.transitions.dynamicTransition action:@selector(handlePanGesture:)];
    
    return _dynamicTransitionPanGesture;
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
    return 10;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

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
