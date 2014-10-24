//
//  VVLeftMenuController.m
//  rentor
//
//  Created by vegera on 10.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVLeftMenuController.h"

#import "VVMenuItemTitleWithIconCell.h"
#import "VVMenuItemAvatarCell.h"
#import "VVMenuItemSpaceCell.h"
#import "VVServerManager.h"

@interface VVLeftMenuController ()

@property (strong, nonatomic) NSArray* tableData;
@property (strong, nonatomic) NSIndexPath* indexPath;

@end

static NSString* menuItemTitleWithIconCell = @"menuItemTitleWithIconCell";
static NSString* menuItemAvatarCell = @"menuItemAvatarCell";
static NSString* menuItemSpaceCell = @"menuItemSpaceCell";

@implementation VVLeftMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView setScrollEnabled:NO];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.f]];
    [self initTableData];
    [self initInfo];
}

- (void)initTableData
{
    self.tableData = @[@{@"type":menuItemAvatarCell,
                         @"title":@"Вегера Виталий",
                         @"phoneNumber":@"45837498573"},
                       
                       @{@"type":menuItemTitleWithIconCell,
                         @"title":@"Все объявления",
                         @"iconName":@"icon_1",
                         @"frame":[NSValue valueWithCGRect:CGRectMake(27, 13, 22, 20)]},
                       
                       @{@"type":menuItemTitleWithIconCell,
                         @"title":@"Мои объявления",
                         @"iconName":@"icon_2",
                         @"frame":[NSValue valueWithCGRect:CGRectMake(27, 13, 24, 21)]},
                       
                       @{@"type":menuItemTitleWithIconCell,
                         @"title":@"Оповещения",
                         @"iconName":@"icon_3",
                         @"frame":[NSValue valueWithCGRect:CGRectMake(30, 11, 17, 25)]},
                       
                       @{@"type":menuItemSpaceCell},
                       
                       @{@"type":menuItemTitleWithIconCell,
                         @"title":@"Добавить недвижимость",
                         @"iconName":@"icon_4",
                         @"frame":[NSValue valueWithCGRect:CGRectMake(28, 11, 22, 22)]},
                       
                       @{@"type":menuItemTitleWithIconCell,
                         @"title":@"Добавить клиента",
                         @"iconName":@"icon_5",
                         @"frame":[NSValue valueWithCGRect:CGRectMake(30, 13, 17, 20)]},
                       
                       @{@"type":menuItemTitleWithIconCell,
                         @"title":@"Настройки",
                         @"iconName":@"icon_6",
                         @"frame":[NSValue valueWithCGRect:CGRectMake(28, 12, 22, 23)]},
                       
                       @{@"type":menuItemTitleWithIconCell,
                         @"title":@"Выход",
                         @"iconName":@"icon_7",
                         @"frame":[NSValue valueWithCGRect:CGRectMake(31, 12, 16, 21)]}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - InitInfo

- (void)initInfo
{
    [[VVServerManager sharedManager] getProfileDataOnSuccess:^(VVUser *user) {
        
        VVMenuItemAvatarCell* cell = (VVMenuItemAvatarCell *) [self.tableView cellForRowAtIndexPath:self.indexPath];
        
        [cell.avatarImageView setImageURL:[NSURL URLWithString:user.photo]];
        [cell.phoneUser setText:[NSString stringWithFormat:@"+7 %@", user.phone]];
        [cell.nameUser setText:[NSString stringWithFormat:@"%@ %@", user.surname, user.firstname]];
        
        [[VVSettings sharedManager] saveUserId:user.user_id];
    }
                                                   onFailure:^(NSError *error, NSInteger statusCode) {
                                                       
                                                       NSLog(@"error: %@, statusCode:%d", error, statusCode);
                                                       
                                                       if (statusCode == 666) {
                                                           [self showAlert:@"Отсутствует соединение с интернетом."];
                                                       } else {
                                                           [self showAlert:@"Ошибка в передаче данных."];
                                                       }
                                                       
                                                   }];
}

#pragma mark - Alert

- (void)showAlert:(NSString *)message
{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Ошибка!"
                          message:message
                          delegate:self  // set nil if you don't want the yes button callback
                          cancelButtonTitle:@"Да"
                          otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* model = [self.tableData objectAtIndex:indexPath.row];
    
    if ([[model objectForKey:@"type"] isEqualToString:menuItemTitleWithIconCell]) {
        return 44.f;
    }
    
    if ([[model objectForKey:@"type"] isEqualToString:menuItemAvatarCell]) {
        return 78.f;
    }
    
    if ([[model objectForKey:@"type"] isEqualToString:menuItemSpaceCell]) {
        CGFloat height = [[UIScreen mainScreen] applicationFrame].size.height;
        CGFloat cell = 7.f * 44.f + 78.f;
        return height - cell;
    }
    return 44.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* defaultCell;
    NSDictionary* model = [self.tableData objectAtIndex:indexPath.row];
    
    if ([[model objectForKey:@"type"] isEqualToString:menuItemTitleWithIconCell]) {
        VVMenuItemTitleWithIconCell* cell = [tableView dequeueReusableCellWithIdentifier:menuItemTitleWithIconCell];
        
        if (!cell) {
            cell = [[VVMenuItemTitleWithIconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuItemTitleWithIconCell];
        }
        
        cell.titleLabel.text = [model objectForKey:@"title"];
        [cell.iconImageView setImage:[UIImage imageNamed:[model objectForKey:@"iconName"]]];
        cell.iconImageView.frame = [[model objectForKey:@"frame"] CGRectValue];
        
        defaultCell = cell;
    }
    
    if ([[model objectForKey:@"type"] isEqualToString:menuItemSpaceCell]) {
        VVMenuItemSpaceCell* cell = [tableView dequeueReusableCellWithIdentifier:menuItemSpaceCell];
        
        if (!cell) {
            cell = [[VVMenuItemSpaceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuItemSpaceCell];
        }
        
        defaultCell = cell;
    }
    
    if ([[model objectForKey:@"type"] isEqualToString:menuItemAvatarCell]) {
        VVMenuItemAvatarCell* cell = [tableView dequeueReusableCellWithIdentifier:menuItemAvatarCell];
        
        if (!cell) {
            cell = [[VVMenuItemAvatarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuItemAvatarCell];
        }
        
        self.indexPath = indexPath;
        defaultCell = cell;
    }
    
    return defaultCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!(indexPath.row == 0 || indexPath.row == 4 || indexPath.row == 8)) { // запретил реагирование на аватарку на левом меню
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    } else if(indexPath.row == 8) {
        NSLog(@"actionLogout");
        [self resetToken];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)resetToken
{
    //    NSUserDefaults* userSettings = [NSUserDefaults standardUserDefaults];
    //    [userSettings removeObjectForKey:kToken];
    //    [userSettings synchronize];
    [[VVSettings sharedManager] removeToken];
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

@end
