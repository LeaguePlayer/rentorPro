//
//  VVMenuTableViewController.m
//  rentor
//
//  Created by vegera on 31.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVMenuTableViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "PAImageView.h"

@interface VVMenuTableViewController ()

@property (nonatomic, strong) UINavigationController *transitionsNavigationController;

@property (weak, nonatomic) IBOutlet PAImageView *avatarImageView;

@end

static NSString* kToken = @"token";

@implementation VVMenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.emptyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.userCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self initInfo];
    
//    self.tableView.frame
    
    // topViewController is the transitions navigation controller at this point.
    // It is initially set as a User Defined Runtime Attributes in storyboards.
    // We keep a reference to this instance so that we can go back to it without losing its state.
    self.transitionsNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
}

#pragma mark - InitInfo

- (void)initInfo
{
    [self.avatarImageView setImageURL:[NSURL URLWithString:@"http://cs616321.vk.me/v616321506/19627/468fNNNqBXg.jpg"]];
}

#pragma mark - UITableViewDataSource

/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"emptyCell"];
        
//        [cell setFrame:CGRectMake(0, 0, 320, 10)];
        [cell setBackgroundColor:[UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0]];
        [cell setSelected:NO];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 5) {
//        return 37.f;
//    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", indexPath);
    switch (indexPath.row) {
        case 0: // account
            NSLog(@"account");
            break;
        case 1: // all adv
            NSLog(@"all adv");
            [self actionMenu:@"VVAdvertisingsAndClientsViewController"];
            break;
        case 2: // my adv
            NSLog(@"my adv");
            [self actionMenu:@"VVMainAdvViewController"];
            break;
        case 3: // notification
            NSLog(@"notification");
            [self actionMenu:@"VVNotificationViewController"];
            break;
        case 5: // add advertising
            NSLog(@"VVCreateRealtyStepOneTableViewController");
            [self actionMenu:@"VVCreateRealtyStepOneTableViewController"];
            break;
        case 6: // add client
            NSLog(@"6666666");
            [self actionMenu:@"VVCreateClientTableViewController"];
            break;
        case 7: // add client
            NSLog(@"Settings");
            [self actionMenu:@"VVSettingsTableViewController"];
            break;
        case 8: // logout
            
            [self actionLogout];
            break;
    }
}

#pragma mark - Actions

- (void)actionMenu:(NSString *)storyboardIdentifier
{
    self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:storyboardIdentifier];
    [self.slidingViewController resetTopViewAnimated:YES];
}

- (void)actionLogout
{
    NSLog(@"actionLogout");
    //TODO: need to clean all user settings
    [self.navigationController popToRootViewControllerAnimated:YES]; // возвращаемся к рутовому контроллеру
}

- (void)resetToken
{
    NSUserDefaults* userSettings = [NSUserDefaults standardUserDefaults];
    [userSettings removeObjectForKey:kToken];
    [userSettings synchronize];
}

@end
