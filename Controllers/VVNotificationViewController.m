//
//  VVNotificationViewController.m
//  rentor
//
//  Created by vegera on 01.08.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVNotificationViewController.h"
#import "VVMainAdvTableViewCell.h"

#import "VVServerManager.h"
#import "VVLoader.h"

#import "VVDetailAdvTableViewController.h"

#import "UIViewController+AMSlideMenu.h"

@interface VVNotificationViewController ()

@property (strong, nonatomic) VVLoader* loaderView;
@property (strong, nonatomic) UILabel* emptyTextView;

@property (strong, nonatomic) NSMutableArray* realtyArray;
@property (strong, nonatomic) NSMutableArray* clientArray;

@property (strong, nonatomic) VVFilterModel* realtyArrayFilter;
@property (strong, nonatomic) VVFilterModel* clientArrayFilter;

@property (strong, nonatomic) NSString* currentTabString;

@property (assign, nonatomic) BOOL flagRealtyRequest;
@property (assign, nonatomic) BOOL flagClientRequest;

@property (assign, nonatomic) BOOL flagRealtyFirstRequest;
@property (assign, nonatomic) BOOL flagClientFirstRequest;

@property (strong, nonatomic) NSString* maxCountRealtyRequest;
@property (strong, nonatomic) NSString* maxCountClientRequest;

@end

static int offsetCountTable = 8;
static NSString* fromServer = @"FromServer";
static NSString* realty = @"realtyArray";
static NSString* client = @"clientArray";
static NSString* filterString = @"Filter";
static NSString* emptyTextString = @"По данному запросу результатов нет";

@implementation VVNotificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.realtyArray = [[NSMutableArray alloc] init];
    self.clientArray = [[NSMutableArray alloc] init];
    _realtyArrayFilter = [[VVFilterModel alloc] init];
    _clientArrayFilter = [[VVFilterModel alloc] init];
    
    self.flagRealtyRequest = NO;
    self.flagClientRequest = NO;
    
    [self realtyArrayFromServer];
    [self addLeftMenuButton];
    
    VVLoader* loaderView = [[VVLoader alloc] initWithFrame:self.tableView.frame];
    [self.view addSubview:loaderView];
    self.loaderView = loaderView;
    
    UILabel* emptyTextView = [[UILabel alloc] initWithFrame:self.tableView.frame];
    [emptyTextView setText:emptyTextString];
    [emptyTextView setTextAlignment:NSTextAlignmentCenter];
    [emptyTextView setAlpha:0.f];
    [self.view addSubview:emptyTextView];
    self.emptyTextView = emptyTextView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateEmptyText {
    if ([self.currentTabString isEqualToString:realty]) { // если вкаладка недвижимости
        if (self.flagRealtyFirstRequest && !self.flagRealtyRequest && !([self.maxCountRealtyRequest integerValue] > 0) && [self.realtyArray count] == 0) {
            [self.emptyTextView setAlpha:1.f];
        } else {
            [self.emptyTextView setAlpha:0.f];
        }
    } else {
        if (self.flagClientFirstRequest && !self.flagClientRequest && !([self.maxCountClientRequest integerValue] > 0) && [self.clientArray count] == 0) {
            [self.emptyTextView setAlpha:1.f];
        } else {
            [self.emptyTextView setAlpha:0.f];
        }
    }
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

#pragma mark - BarButtonMenu

- (void)addLeftMenuButton
{
    UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tab"]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(actionShowMenu)];
    
    [self.navigationItem setLeftBarButtonItem:button];
}

- (void)listenNotification:(NSNotification *)notification
{
    NSLog(@"%@", notification);
    [self setValue:[notification.object objectForKey:@"model"] forKey:[notification.object objectForKey:@"filter"]];
}

- (void)actionShowMenu
{
    [self.mainSlideMenu openLeftMenu];
}

- (void)setCurrentTabString:(NSString *)currentTabString
{
    NSLog(@"setCurrentTabString");
    _currentTabString = currentTabString;
    [self.tableView reloadData];
    
    if (![[self valueForKey:[self currentTabString]] count]) {
        [self loadFromServer];
    }
    [self updateEmptyText];
}

- (NSString *)getServerMethod
{
    NSLog(@"%@%@", [self currentTabString], fromServer);
    return [NSString stringWithFormat:@"%@%@", [self currentTabString], fromServer];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue");
    NSLog(@"sender: %@", sender);
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"detailAdvSegue"]) {
        
        // Get destination view
        VVDetailAdvTableViewController *controller = [segue destinationViewController];
        
        // Pass the information to your destination view
        [controller setValue:[sender valueForKey:@"model"] forKey:@"model"];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.currentTabString == nil) {
        _currentTabString = realty;
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
    }
    
    if (indexPath.row > [[self valueForKey:[self currentTabString]] count] - offsetCountTable) {
        [self loadFromServer];
    }
    
    VVRealty* model = [[self valueForKey:[self currentTabString]] objectAtIndex:indexPath.row];
    
    if (!model.notices) {
        [cell setBackgroundColor:[UIColor grayColor]];
    } else {
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    
    cell.countRoomLabel.text = model.what;
    cell.titleLabel.text = [NSString stringWithFormat:@"%@, %@", model.region.length == 0 ? @"Р-он не указан" : model.region, model.price];
    //        cell.roomLabel.text = model.what; //@"комнаты";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
    VVRealty* model = [[self valueForKey:[self currentTabString]] objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detailAdvSegue" sender:@{@"model": model}];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
}

#pragma mark - API

// метод, который решает, клиентов или недвижимость надо подгружать
- (void)loadFromServer
{
    [self valueForKey:[self getServerMethod]];
}

- (void)realtyArrayFromServer {
    
    if (self.flagRealtyRequest) {
        return;
    }
    
    self.flagRealtyFirstRequest = YES;
    self.flagRealtyRequest = YES;
    [self.loaderView setAlpha:1.f];
    
    [[VVServerManager sharedManager] getNotificationAdvWithLimit:20
                                                          offset:[self.realtyArray count]
                                                            type:@"estate"
                                                       onSuccess:^(NSArray* adv, NSString* count) {
                                               
                                                           NSLog(@"onSuccess: %@", adv);
                                                           NSLog(@"onSuccess count: %@", count);
                                                           self.maxCountRealtyRequest = count;
                                               
                                                           if ([adv count] > 0) {
                                                               [self.realtyArray addObjectsFromArray:adv];
                                                               [self.tableView reloadData];
                                                           }
                                               
                                                           self.flagRealtyRequest = NO;
                                                           [self updateEmptyText];
                                                           [self.loaderView setAlpha:0.f];
                                                       }
                                                       onFailure:^(NSError *error, NSInteger statusCode) {
                                                           self.flagRealtyRequest = NO;
                                                           NSLog(@"error: %@, statusCode:%d", error, statusCode);
                                                           if (statusCode == 666) {
                                                               [self showAlert:@"Отсутствует соединение с интернетом."];
                                                           } else {
                                                               [self showAlert:@"Ошибка в передаче данных."];
                                                           }
                                                           [self updateEmptyText];
                                                           [self.loaderView setAlpha:0.f];
                                                       }];
}

- (void)clientArrayFromServer {
    
    if (self.flagClientRequest) {
        return;
    }
    
    self.flagClientFirstRequest = YES;
    self.flagClientRequest = YES;
    [self.loaderView setAlpha:1.f];
    
    [[VVServerManager sharedManager] getNotificationAdvWithLimit:20
                                                          offset:[self.clientArray count]
                                                            type:@"client"
                                                       onSuccess:^(NSArray* adv, NSString* count) {
                                                           NSLog(@"onSuccess: %@", adv);
                                                           NSLog(@"onSuccess count: %@", count);
                                                           self.maxCountClientRequest = count;
                                               
                                                           if ([adv count] > 0) {
                                                               [self.clientArray addObjectsFromArray:adv];
                                                               [self.tableView reloadData];
                                                           }
                                               
                                                           self.flagClientRequest = NO;
                                                           [self updateEmptyText];
                                                           [self.loaderView setAlpha:0.f];
                                                       }
                                                       onFailure:^(NSError *error, NSInteger statusCode) {
                                                           self.flagClientRequest = NO;
                                                           NSLog(@"error: %@, statusCode:%d", error, statusCode);
                                                           if (statusCode == 666) {
                                                               [self showAlert:@"Отсутствует соединение с интернетом."];
                                                           } else {
                                                               [self showAlert:@"Ошибка в передаче данных."];
                                                           }
                                                           [self updateEmptyText];
                                                           [self.loaderView setAlpha:0.f];
                                                       }];
}

#pragma mark - Actions

- (IBAction)actionTab:(UISegmentedControl *)sender {
    if (self.tabSegmentedControl.selectedSegmentIndex == 0) {
        NSLog(@"actionTab: Недвижимость");
        self.currentTabString = realty;
    }
    
    if (self.tabSegmentedControl.selectedSegmentIndex == 1) {
        NSLog(@"actionTab: Клиенты");
        self.currentTabString = client;
    }
}

- (IBAction)menuButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"filterSegue" sender:@{@"model": ([self.currentTabString isEqualToString:realty] ? self.realtyArrayFilter : self.clientArrayFilter)}];
}

@end
