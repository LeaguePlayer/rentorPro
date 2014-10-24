//
//  VVSettingsTableViewController.m
//  rentor
//
//  Created by A-Mobile LLC on 24.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVSettingsTableViewController.h"
#import "VVServerManager.h"
#import "MBProgressHUD.h"

#import "UIViewController+AMSlideMenu.h"

@interface VVSettingsTableViewController ()

@end

@implementation VVSettingsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self addLeftMenuButton];
    
    [self refreshAccessory];
    [self cellDesabledSelect];
    [self loadFromServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - API

- (void)loadFromServer
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[VVServerManager sharedManager] getProfileDataOnSuccess:^(VVUser *user) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//        self.avatarImage = [];
        [self.avatarImageView setImageURL:[NSURL URLWithString:user.photo]];
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", user.surname, user.firstname];
        self.balanceLabel.text = [NSString stringWithFormat:@"%@ руб.", user.balance]; // @"123 руб."; // баланс
        self.rateLabel.text = user.tariff_title; // @"тариф"; // тариф
        self.dueDateLabel.text = [user getDatePaid];// @"20.08.2014 22:45"; // тариф оплачен
//        self.needToMakeLabel.text = @"хз руб"; // необходимо внести
        self.countAdv.text = [NSString stringWithFormat:@"%@ штук", user.ad_count]; // @"34 штук"; // объявлений
        self.phoneNumberLabel.text = user.phone;// @"+7 982 942 17 09"; // Номер телефона
        self.createDateUserAccount.text = [user getDateCreated]; // @"23.07.2014 12:47"; // Дата регистрации
        self.lastVisitLabel.text = [user getDateLogged]; // @"11.07.2014 10:47"; // Последний визит
        self.emailLabel.text = user.email; // @"vegera.vitaly@gmail.com"; // E-mail
    }
                                                   onFailure:^(NSError *error, NSInteger statusCode) {
                                                       NSLog(@"error: %@, statusCode:%d", error, statusCode);
                                                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                       if (statusCode == 666) {
                                                           [self showAlert:@"Отсутствует соединение с интернетом."];
                                                       } else {
                                                           [self showAlert:@"Ошибка в передаче данных."];
                                                       }
                                                   }];
}

#pragma mark - Accessory

- (void)refreshAccessory
{
    for (UITableViewCell* cell in self.cellForChangeAccessoryCollection) {
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconSegue.png"]]];
    }
}

- (void)cellDesabledSelect
{
    for (UITableViewCell* cell in self.cellForDesabledSelectCollection) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

#pragma mark - Actions

- (IBAction)menuButtonTapped:(id)sender
{
//    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath: %@", indexPath);
    switch (indexPath.row) {
        case 5:
            [self performSegueWithIdentifier:@"myAdvSegue" sender:nil];
            break;
    }
}

@end
