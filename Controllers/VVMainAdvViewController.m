//
//  VVMainAdvViewController.m
//  rentor
//
//  Created by vegera on 30.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVMainAdvViewController.h"
#import "VVSwipeCell.h"

#import "VVLoader.h"

#import "VVFilterModel.h"

#import "VVServerManager.h"

#import "VVDetailAdvTableViewController.h"
#import "VVEditController.h"

#import "DDAUIActionSheetViewController.h"

#import "UIViewController+AMSlideMenu.h"

@interface VVMainAdvViewController ()

@property (strong, nonatomic) VVLoader* loaderView;
@property (strong, nonatomic) UILabel* emptyTextView;
@property (strong, nonatomic) NSString* actionForRow;

@property (nonatomic) DDAUIActionSheetViewController *customActionSheet;

@property (strong, nonatomic) NSMutableArray* selectedArray;

@property (strong, nonatomic) NSMutableArray* allArray; // все
@property (strong, nonatomic) NSMutableArray* realtyArray; // недвижимость
@property (strong, nonatomic) NSMutableArray* clientArray; // клиенты
@property (strong, nonatomic) NSMutableArray* rentedArray; // сдано/снято

@property (strong, nonatomic) NSString* currentTabString; // code current tab

@property (assign, nonatomic) BOOL flagRealtyRequest;
@property (assign, nonatomic) BOOL flagClientRequest;
@property (assign, nonatomic) BOOL flagAllRequest;
@property (assign, nonatomic) BOOL flagRentedRequest;

@property (assign, nonatomic) BOOL flagRealtyFirstRequest;
@property (assign, nonatomic) BOOL flagClientFirstRequest;
@property (assign, nonatomic) BOOL flagAllFirstRequest;
@property (assign, nonatomic) BOOL flagRentedFirstRequest;

@property (strong, nonatomic) NSString* maxCountRealtyRequest;
@property (strong, nonatomic) NSString* maxCountClientRequest;
@property (strong, nonatomic) NSString* maxCountAllRequest;
@property (strong, nonatomic) NSString* maxCountRentedRequest;

@end

static NSString* swipeCell = @"swipeCell";
static int offsetCountTable = 8;
static int CountLoadCell = 20;
static NSString* fromServer = @"FromServer";
static NSString* realty = @"realtyArray";
static NSString* client = @"clientArray";
static NSString* all = @"allArray";
static NSString* rented = @"rentedArray";
static NSString* emptyTextString = @"По данному запросу результатов нет";

@implementation VVMainAdvViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.customActionSheet = [[DDAUIActionSheetViewController alloc] init];
    
    self.customActionSheet.delegate = self;
    
    [self addLeftMenuButton];
    
    self.allArray = [[NSMutableArray alloc] init];
    self.clientArray = [[NSMutableArray alloc] init];
    self.realtyArray = [[NSMutableArray alloc] init];
    self.rentedArray = [[NSMutableArray alloc] init];
    
    self.flagRealtyRequest = NO;
    self.flagClientRequest = NO;
    self.flagAllRequest = NO;
    self.flagRentedRequest = NO;
    
    [self allArrayFromServer];
    
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
    }
    if ([self.currentTabString isEqualToString:client]) {
        if (self.flagClientFirstRequest && !self.flagClientRequest && !([self.maxCountClientRequest integerValue] > 0) && [self.clientArray count] == 0) {
            [self.emptyTextView setAlpha:1.f];
        } else {
            [self.emptyTextView setAlpha:0.f];
        }
    }
    if ([self.currentTabString isEqualToString:all]) {
        if (self.flagAllFirstRequest && !self.flagAllRequest && !([self.maxCountAllRequest integerValue] > 0) && [self.allArray count] == 0) {
            [self.emptyTextView setAlpha:1.f];
        } else {
            [self.emptyTextView setAlpha:0.f];
        }
    }
    if ([self.currentTabString isEqualToString:rented]) {
        if (self.flagRentedFirstRequest && !self.flagRentedRequest && !([self.maxCountRentedRequest integerValue] > 0) && [self.rentedArray count] == 0) {
            [self.emptyTextView setAlpha:1.f];
        } else {
            [self.emptyTextView setAlpha:0.f];
        }
    }
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

- (void)setActionForRow:(NSString *)actionForRow
{
    NSLog(@"setActionForRow: %@", actionForRow);
    [self getSelectedIds];
    if ([actionForRow isEqualToString:@"actionDelete"]) {
        [self deleteAdv];
    } else if ([actionForRow isEqualToString:@"actionUnset"]) {
        [self finishedAdv];
    } else if ([actionForRow isEqualToString:@"actionProlong"]) {
        [self prolongAdv];
    }
}

- (void)resetSettings
{
    
    [self.allArray removeAllObjects];
    [self.realtyArray removeAllObjects];
    [self.clientArray removeAllObjects];
    [self.rentedArray removeAllObjects];
    
    self.flagRealtyRequest = NO;
    self.flagClientRequest = NO;
    self.flagAllRequest = NO;
    self.flagRentedRequest = NO;
    
    self.flagRealtyFirstRequest = NO;
    self.flagClientFirstRequest = NO;
    self.flagAllFirstRequest = NO;
    self.flagRentedFirstRequest = NO;
    
    self.maxCountRealtyRequest = @"0";
    self.maxCountClientRequest = @"0";
    self.maxCountAllRequest = @"0";
    self.maxCountRentedRequest = @"0";
}

- (void)getSelectedIds
{
    NSMutableArray* array = [NSMutableArray array];
    for (VVRealty* item in [self valueForKey:[self currentTabString]]) {
        if (item.selected) {
            [array addObject:item];
        }
    }
    self.selectedArray = array;
}

#pragma mark - BarButtonMenu

- (void)addLeftMenuButton
{
    UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tab"]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(actionShowMenu)];
    
    [self.navigationItem setLeftBarButtonItem:button];
}

- (void)actionShowMenu
{
    [self.mainSlideMenu openLeftMenu];
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
    
    if ([[segue identifier] isEqualToString:@"editSegue"]) {
        
        // Get destination view
        VVEditController *controller = (VVEditController *) [segue destinationViewController];
        
        // Pass the information to your destination view
        [controller setValue:[sender valueForKey:@"model"] forKey:@"model"];
    }
}

#pragma mark - SWTableViewCellDelegate

// click event on right utility button
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    NSLog(@"didTriggerRightUtilityButtonWithIndex: %ld", (long)index);
    
    [self performSegueWithIdentifier:@"editSegue" sender:@{@"model": (VVRealty *) [[self valueForKey:[self currentTabString]] objectAtIndex:index]}];
    
//    [self.navigationController.view addSubview:self.customActionSheet.view];
//    NSLog(@"%@", self.view);
//    [self.customActionSheet viewWillAppear:NO];
}

// utility button open/close event
- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    NSLog(@"scrollingToState: %d", state);
}

// prevent multiple cells from showing utilty buttons simultaneously
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}

// prevent cell(s) from displaying left/right utility buttons
- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    return YES;
}

#pragma mark - API

- (NSString *)getServerMethod
{
    NSLog(@"%@%@", [self currentTabString], fromServer);
    return [NSString stringWithFormat:@"%@%@", [self currentTabString], fromServer];
}

// метод, который решает, клиентов или недвижимость надо подгружать
- (void)loadFromServer
{
    [self valueForKey:[self getServerMethod]];
}

- (void)finishedAdv
{
    for (VVRealty* item in self.selectedArray) {
        [self.loaderView setAlpha:1.f];
        [[VVServerManager sharedManager] getFinishedAdvById:item.id
                                                  onSuccess:^(NSString *result) {
                                                      [self.loaderView setAlpha:0.f];
//                                                      [self.tableView reloadData];
                                                      
                                                      [self resetSettings];
                                                      [self loadFromServer];
                                                  }
                                                  onFailure:^(NSError *error, NSInteger statusCode) {
                                                      NSLog(@"error: %@, statusCode:%d", error, statusCode);
                                                      [self.loaderView setAlpha:0.f];
                                                      if (statusCode == 666) {
                                                          [self showAlert:@"Отсутствует соединение с интернетом."];
                                                      } else {
                                                          [self showAlert:@"Ошибка в передаче данных."];
                                                      }
                                                  }];
    }
}

- (void)prolongAdv
{
    for (VVRealty* item in self.selectedArray) {
        [self.loaderView setAlpha:1.f];
        [[VVServerManager sharedManager] getProlongeAdvById:item.id
                                                  onSuccess:^(NSString *result) {
                                                      [self.loaderView setAlpha:0.f];
//                                                      [self.tableView reloadData];
                                                      
                                                      [self resetSettings];
                                                      [self loadFromServer];
                                                  }
                                                  onFailure:^(NSError *error, NSInteger statusCode) {
                                                      NSLog(@"error: %@, statusCode:%d", error, statusCode);
                                                      [self.loaderView setAlpha:0.f];
                                                      if (statusCode == 666) {
                                                          [self showAlert:@"Отсутствует соединение с интернетом."];
                                                      } else {
                                                          [self showAlert:@"Ошибка в передаче данных."];
                                                      }
                                                  }];
    }
}

- (void)deleteAdv
{
    for (VVRealty* item in self.selectedArray) {
        [self.loaderView setAlpha:1.f];
        [[VVServerManager sharedManager] getRemoveAdvById:item.id
                                                onSuccess:^(NSString *result) {
                                                    [self.loaderView setAlpha:0.f];
//                                                    [self.tableView reloadData];
                                                    
                                                    [self resetSettings];
                                                    [self loadFromServer];
                                                }
                                                onFailure:^(NSError *error, NSInteger statusCode) {
                                                    NSLog(@"error: %@, statusCode:%d", error, statusCode);
                                                    [self.loaderView setAlpha:0.f];
                                                    if (statusCode == 666) {
                                                        [self showAlert:@"Отсутствует соединение с интернетом."];
                                                    } else {
                                                        [self showAlert:@"Ошибка в передаче данных."];
                                                    }
                                                }];
    }
}

- (void)allArrayFromServer {
    
    if (self.flagAllRequest) {
        return;
    }
    
    self.flagAllFirstRequest = YES;
    self.flagAllRequest = YES; 
    [self.loaderView setAlpha:1.f];
    
    // filter for current user
    VVFilterModel* filterModel = [[VVFilterModel alloc] init];
    [filterModel setUser_id:[[VVSettings sharedManager] getUserId]];
    [filterModel setFinished:@"0"];
    
    [[VVServerManager sharedManager] getAdvForEditWithLimit:CountLoadCell
                                                     offset:[self.allArray count]
                                                       type:@""
                                                     filter:(VVFilterModel *)filterModel
                                                  onSuccess:^(NSArray* adv, NSString* count) {
                                                      NSLog(@"onSuccess: %@", adv);
                                                      NSLog(@"onSuccess count: %@", count);
                                               
                                                      if ([adv count] > 0) {
                                                          [self.allArray addObjectsFromArray:adv];
                                                          [self.tableView reloadData];
                                                      }
                                               
                                                      self.flagAllRequest = NO;
                                                      [self updateEmptyText];
                                                      [self.loaderView setAlpha:0.f];
                                                  }
                                                  onFailure:^(NSError *error, NSInteger statusCode) {
                                                      self.flagAllRequest = NO;
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

- (void)realtyArrayFromServer {
    
    if (self.flagRealtyRequest) {
        return;
    }
    
    self.flagRealtyRequest = YES;
    
    // filter for current user
    VVFilterModel* filterModel = [[VVFilterModel alloc] init];
    [filterModel setUser_id:[[VVSettings sharedManager] getUserId]];
    [filterModel setFinished:@"0"];
    
    [[VVServerManager sharedManager] getAdvForEditWithLimit:CountLoadCell
                                                     offset:[self.realtyArray count]
                                                       type:@"estate"
                                                     filter:(VVFilterModel *)filterModel
                                                  onSuccess:^(NSArray* adv, NSString* count) {
                                               //                                               self.maxCountRealtyRequest = count;
                                               
                                                      NSLog(@"onSuccess: %@", adv);
                                                      NSLog(@"onSuccess count: %@", count);
                                               
                                                      if ([adv count] > 0) {
                                                          [self.realtyArray addObjectsFromArray:adv];
                                                          [self.tableView reloadData];
                                                      }
                                               
                                                      self.flagRealtyRequest = NO;
                                               
                                                  }
                                                  onFailure:^(NSError *error, NSInteger statusCode) {
                                                      self.flagRealtyRequest = NO;
                                                      NSLog(@"error: %@, statusCode:%d", error, statusCode);
                                                      if (statusCode == 666) {
                                                          [self showAlert:@"Отсутствует соединение с интернетом."];
                                                      } else {
                                                          [self showAlert:@"Ошибка в передаче данных."];
                                                      }
                                                  }];
}

- (void)clientArrayFromServer {
    
    if (self.flagClientRequest) {
        return;
    }
    
    self.flagClientRequest = YES;
    
    // filter for current user
    VVFilterModel* filterModel = [[VVFilterModel alloc] init];
    [filterModel setUser_id:[[VVSettings sharedManager] getUserId]];
    [filterModel setFinished:@"0"];
    
    [[VVServerManager sharedManager] getAdvForEditWithLimit:CountLoadCell
                                                     offset:[self.clientArray count]
                                                       type:@"client"
                                                     filter:(VVFilterModel *)filterModel
                                                  onSuccess:^(NSArray* adv, NSString* count) {
                                                      NSLog(@"onSuccess: %@", adv);
                                                      NSLog(@"onSuccess count: %@", count);
                                               
                                                      if ([adv count] > 0) {
                                                          [self.clientArray addObjectsFromArray:adv];
                                                          [self.tableView reloadData];
                                                      }
                                               
                                                      self.flagClientRequest = NO;
                                                  }
                                                  onFailure:^(NSError *error, NSInteger statusCode) {
                                                      self.flagClientRequest = NO;
                                                      NSLog(@"error: %@, statusCode:%d", error, statusCode);
                                                      if (statusCode == 666) {
                                                          [self showAlert:@"Отсутствует соединение с интернетом."];
                                                      } else {
                                                          [self showAlert:@"Ошибка в передаче данных."];
                                                      }
                                                  }];
}

- (void)rentedArrayFromServer {
    
    if (self.flagRentedRequest) {
        return;
    }
    
    self.flagRentedRequest = YES;
    
    // filter for current user
    VVFilterModel* filterModel = [[VVFilterModel alloc] init];
    [filterModel setUser_id:[[VVSettings sharedManager] getUserId]];
    [filterModel setFinished:@"1"];
    
    [[VVServerManager sharedManager] getAdvForEditWithLimit:CountLoadCell
                                                     offset:[self.rentedArray count]
                                                       type:@""
                                                     filter:(VVFilterModel *)filterModel
                                                  onSuccess:^(NSArray* adv, NSString* count) {
                                                      NSLog(@"onSuccess: %@", adv);
                                                      NSLog(@"onSuccess count: %@", count);
                                               
                                                      if ([adv count] > 0) {
                                                          [self.rentedArray addObjectsFromArray:adv];
                                                          [self.tableView reloadData];
                                                      }
                                               
                                                      self.flagRentedRequest = NO;
                                                  }
                                                  onFailure:^(NSError *error, NSInteger statusCode) {
                                                      self.flagRentedRequest = NO;
                                                      NSLog(@"error: %@, statusCode:%d", error, statusCode);
                                                      if (statusCode == 666) {
                                                          [self showAlert:@"Отсутствует соединение с интернетом."];
                                                      } else {
                                                          [self showAlert:@"Ошибка в передаче данных."];
                                                      }
                                                  }];
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.currentTabString == nil) {
        _currentTabString = all;
    }
    NSString* identifier = [self currentTabString];
    NSLog(@"%@", identifier);
    NSLog(@"numberOfRowsInSection: %d", [[self valueForKey:identifier] count]);
    return [[self valueForKey:identifier] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    VVSwipeCell* cell = [tableView dequeueReusableCellWithIdentifier:swipeCell];
    
    if (!cell) {
        cell = [[VVSwipeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:swipeCell];
//        cell.rightUtilityButtons = [self rightButtons];
    }
    
    if (indexPath.row > [[self valueForKey:[self currentTabString]] count] - offsetCountTable) {
        [self loadFromServer];
    }
    
    VVRealty* model = [[self valueForKey:[self currentTabString]] objectAtIndex:indexPath.row];
    [cell setModel:model];
    
    cell.delegate = self;
    [cell setDelegateController:self];
    
    return cell;
}

- (void)actionChecked
{
    NSLog(@"actionChecked");
    
    [self.navigationController.view addSubview:self.customActionSheet.view];
    NSLog(@"%@", self.view);
    [self.customActionSheet viewWillAppear:NO];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"didSelectRowAtIndexPath");
    VVRealty* model = [[self valueForKey:[self currentTabString]] objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detailAdvSegue" sender:@{@"model": model}];
}

#pragma mark - UIActionSheetDelegate

//- (void)attachmentActionSheet:(UITextView *)textView range:(NSRange)range {
//    
//    // get the rect for the selected attachment (if its a big image with top not visible the action sheet
//    // will be positioned above the top limit of the UITextView
//    // Need to add code to adjust for this.
//    CGRect attachmentRect = [self frameOfTextRange:range inTextView:textView];
//    
//    _attachmentMenuSheet = [[UIActionSheet alloc] initWithTitle:nil
//                                                       delegate:self
//                                              cancelButtonTitle:@"Cancel"
//                                         destructiveButtonTitle:nil
//                                              otherButtonTitles:@"Copy Image", @"Save to Camera Roll", @"Open in Viewer", nil];
//    
//    // Show the sheet
//    [_attachmentMenuSheet showFromRect:attachmentRect inView:textView animated:YES];
//}

//- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
//    NSLog(@"actionSheet: %ld", (long)buttonIndex);

//    if (actionSheet == _attachmentMenuSheet) {
//        //FLOG(@"Button %d", buttonIndex);
//        switch (buttonIndex) {
//                
//            case 0:
//                //FLOG(@" Copy Image");
//                [self copyImageToPasteBoard:[_attachment image]];
//                break;
//                
//            case 1:
//                //FLOG(@"  Save to Camera Roll");
//                [self saveToCameraRoll:[_attachment image]];
//                break;
//                
//            case 2:
//                //FLOG(@"  Open in Viewer");
//                [self browseImage:[_attachment image]];
//                break;
//                
//            default:
//                break;
//        }
//    }
//}

#pragma mark - Actions

- (IBAction)actionEditTableCell:(UIBarButtonItem *)sender {
    
//    [self.tableView setEditing:YES animated:YES];
    
    [self.navigationController.view addSubview:self.customActionSheet.view];
    NSLog(@"%@", self.view);
    [self.customActionSheet viewWillAppear:NO];
    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
//                                                             delegate:self
//                                                    cancelButtonTitle:@"Отмена"
//                                               destructiveButtonTitle:nil
//                                                    otherButtonTitles:@"Удалить", @"Снять", @"Продлить", nil];
//    
//    [actionSheet showInView:self.view];
}

- (IBAction)actionTab:(UISegmentedControl *)sender {
    if (self.tabSegmentedControl.selectedSegmentIndex == 0) {
        NSLog(@"actionTab: Все");
        self.currentTabString = all;
    }
    
    if (self.tabSegmentedControl.selectedSegmentIndex == 1) {
        NSLog(@"actionTab: Недвижимость");
        self.currentTabString = realty;
    }
    
    if (self.tabSegmentedControl.selectedSegmentIndex == 2) {
        NSLog(@"actionTab: Клиенты");
        self.currentTabString = client;
    }
    
    if (self.tabSegmentedControl.selectedSegmentIndex == 3) {
        NSLog(@"actionTab: Снято");
        self.currentTabString = rented;
    }
}
@end
