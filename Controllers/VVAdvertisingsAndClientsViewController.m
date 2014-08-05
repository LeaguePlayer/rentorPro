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

@property (strong, nonatomic) NSString* currentTabString;

@end

static NSString* notificationKey = @"filterNotification";

@implementation VVAdvertisingsAndClientsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(listenNotification:)
                                                 name:notificationKey
                                               object:nil];
    
    [self getTopicsFromServer];
    
    self.transitions.dynamicTransition.slidingViewController = self.slidingViewController;
}

- (void)listenNotification:(NSNotification *)notification
{
    NSLog(@"%@", notification);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setCurrentTabString:(NSString *)currentTabString
{
    NSLog(@"setCurrentTabString");
    _currentTabString = currentTabString;
    [self.tableView reloadData];
}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue");
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.currentTabString == nil) {
        _currentTabString = @"realtyArray";
    }
    NSString* identifier = [self currentTabString];
    NSLog(@"%@", identifier);
    NSLog(@"numberOfRowsInSection: %d", [[self valueForKey:identifier] count]);
    return [[self valueForKey:identifier] count];
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
}

#pragma mark - API

- (void)getTopicsFromServer {
    
    NSArray* array = @[@{},@{},@{},@{},@{},@{},@{}];
    NSArray* array2 = @[@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{}];
    NSMutableArray* arrayM = [NSMutableArray arrayWithArray:array];
    NSMutableArray* arrayM2 = [NSMutableArray arrayWithArray:array2];
    self.realtyArray = arrayM;
    self.clientArray = arrayM2;
    
    NSLog(@"%@", self.realtyArray);
    NSLog(@"%@", self.clientArray);
    
    [self.tableView reloadData];
    
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
        self.currentTabString = @"realtyArray";
    }
    
    if (self.tabSegmentedControl.selectedSegmentIndex == 1) {
        NSLog(@"actionTab: Клиенты");
        self.currentTabString = @"clientArray";
    }
}


- (IBAction)menuButtonTapped:(id)sender
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (IBAction)actionSetFilter:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"filterSegue" sender:@{@"testKey": @"testObject"}];
}

@end
