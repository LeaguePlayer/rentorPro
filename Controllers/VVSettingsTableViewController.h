//
//  VVSettingsTableViewController.h
//  rentor
//
//  Created by A-Mobile LLC on 24.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VVSettingsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView* avatarImage;
@property (weak, nonatomic) IBOutlet UILabel* nameLabel;

@property (weak, nonatomic) IBOutlet UILabel* balanceLabel; // баланс

@property (weak, nonatomic) IBOutlet UILabel* rateLabel; // тариф

@property (weak, nonatomic) IBOutlet UILabel* dueDateLabel; // тариф оплачен

@property (weak, nonatomic) IBOutlet UILabel* needToMakeLabel; // необходимо внести

@property (weak, nonatomic) IBOutlet UILabel* countAdv; // объявлений

@property (weak, nonatomic) IBOutlet UILabel* phoneNumberLabel; // Номер телефона

@property (weak, nonatomic) IBOutlet UILabel* createDateUserAccount; // Дата регистрации

@property (weak, nonatomic) IBOutlet UILabel* lastVisitLabel; // Последний визит

@property (weak, nonatomic) IBOutlet UILabel* emailLabel; // E-mail

@end
