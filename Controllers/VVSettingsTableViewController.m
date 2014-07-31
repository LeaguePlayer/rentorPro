//
//  VVSettingsTableViewController.m
//  rentor
//
//  Created by A-Mobile LLC on 24.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVSettingsTableViewController.h"
#import "UIViewController+ECSlidingViewController.h"

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
    
    [self refreshAccessory];
    [self cellDesabledSelect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initSettings

- (void)loadSettings
{
//    UIImageView* imageView = [[UIImageView alloc] init];
//    self.avatarImage;
    self.nameLabel.text = @"Вегера Виталий";
    
    self.balanceLabel.text = @"123 руб."; // баланс
    
    self.rateLabel.text = @"тариф"; // тариф
    
    self.dueDateLabel.text = @"20.08.2014 22:45"; // тариф оплачен
    
    self.needToMakeLabel.text = @"123 руб"; // необходимо внести
    
    self.countAdv.text = @"34 штук"; // объявлений
    
    self.phoneNumberLabel.text = @"+7 982 942 17 09"; // Номер телефона
    
    self.createDateUserAccount.text = @"23.07.2014 12:47"; // Дата регистрации
    
    self.lastVisitLabel.text = @"11.07.2014 10:47"; // Последний визит
    
    self.emailLabel.text = @"vegera.vitaly@gmail.com"; // E-mail
}

- (void)saveSettings
{
    //
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
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
}

#pragma mark - Actions

- (IBAction)menuButtonTapped:(id)sender
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

@end
