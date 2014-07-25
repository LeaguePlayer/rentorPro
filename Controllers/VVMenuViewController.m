//
//  VVMenuViewController.m
//  rentor
//
//  Created by A-Mobile LLC on 24.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVMenuViewController.h"
#import "UIViewController+ECSlidingViewController.h"

@interface VVMenuViewController ()

@property (strong, nonatomic) NSArray* menuItems;
@property (strong, nonatomic) UINavigationController* transitionsNavigationController;

@end

@implementation VVMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // topViewController is the transitions navigation controller at this point.
    // It is initially set as a User Defined Runtime Attributes in storyboards.
    // We keep a reference to this instance so that we can go back to it without losing its state.
    self.transitionsNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark - Properties

- (NSArray *)menuItems {
    if (_menuItems) return _menuItems;
    
    _menuItems = @[@{@"icon": @"allAdv.png",        @"title": @"Все объявления",        @"code": @""},
                   @{@"icon": @"myAdv.png",         @"title": @"Все объявления",        @"code": @""},
                   @{@"icon": @"notification.png",  @"title": @"Оповещения",            @"code": @""},
                   @{@"icon": @"addHome.png",       @"title": @"Добавить недвижимость", @"code": @""},
                   @{@"icon": @"addClient.png",     @"title": @"Добавить клиента",      @"code": @""},
                   @{@"icon": @"settings.png",      @"title": @"Настройки",             @"code": @"VVSettingsTableViewController"},
                   @{@"icon": @"exit.png",          @"title": @"Выход",                 @"code": @"c"}];
    
    return _menuItems;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *menuItem = self.menuItems[indexPath.row];
    
    // This undoes the Zoom Transition's scale because it affects the other transitions.
    // You normally wouldn't need to do anything like this, but we're changing transitions
    // dynamically so everything needs to start in a consistent state.
    self.slidingViewController.topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
    
    /*if ([menuItem isEqualToString:@"Transitions"]) {
        self.slidingViewController.topViewController = self.transitionsNavigationController;
    } else if ([menuItem isEqualToString:@"Settings"]) {
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MESettingsNavigationController"];
    }*/
    
    if ([menuItem isEqualToString:@"VVSettingsTableViewController"]) {
        // some code for exit this account
    } else {
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:menuItem];
    }
    
    
    [self.slidingViewController resetTopViewAnimated:YES];
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
