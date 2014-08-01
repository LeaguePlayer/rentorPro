//
//  VVFilterTableViewController.m
//  rentor
//
//  Created by vegera on 29.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVFilterTableViewController.h"
#import "VVFilterModel.h"

@interface VVFilterTableViewController ()

@property (strong, nonatomic) VVFilterModel* model;

@end

static NSString* kSettingsTypeRealtyId              = @"typeRealtyId";
static NSString* kSettingsTypeRealtyLabel           = @"typeRealtyLabel";
static NSString* kSettingsDistrictId                = @"districtId";
static NSString* kSettingsDistrictLabel             = @"districtLabel";
static NSString* kSettingsFurnitureId               = @"furnitureId";
static NSString* kSettingsFurnitureLabel            = @"furnitureLabel";
static NSString* kSettingsPeriodId                  = @"periodId";
static NSString* kSettingsPeriodLabel               = @"periodLabel";
static NSString* kSettingsAdditionalyOptionsIds     = @"additionalyOptionsIds";
static NSString* kSettingsAdditionalyOptionsLabel   = @"additionalyOptionsLabel";
static NSString* kSettingsCostFrom                  = @"costFrom";
static NSString* kSettingsCostTo                    = @"costTo";

@implementation VVFilterTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refreshAccessory];
    [self cellDesabledSelect];
    [self textFieldInit];
    [self loadSettings];
}

- (void)textFieldInit
{
    self.costFromTextField.frame = CGRectMake(113, 19, 185, 44);
    self.costToTextField.frame = CGRectMake(113, 110, 185, 44);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - save and load settings

- (void)saveSettings
{
    NSUserDefaults* userSettings = [NSUserDefaults standardUserDefaults];
    
    [userSettings setInteger:self.model.typeRealtyId forKey:kSettingsTypeRealtyId];
    [userSettings setInteger:self.model.districtId forKey:kSettingsDistrictId];
    [userSettings setInteger:self.model.furnitureId forKey:kSettingsDistrictId];
    [userSettings setInteger:self.model.periodId forKey:kSettingsPeriodId];
    [userSettings setInteger:self.model.costFrom forKey:kSettingsCostFrom];
    [userSettings setInteger:self.model.costTo forKey:kSettingsCostTo];
    
    [userSettings setObject:self.model.additionalyOptionsIds forKey:kSettingsAdditionalyOptionsIds];
    [userSettings setObject:self.model.typeRealtyLabel forKey:kSettingsTypeRealtyLabel];
    [userSettings setObject:self.model.districtLabel forKey:kSettingsDistrictLabel];
    [userSettings setObject:self.model.furnitureLabel forKey:kSettingsFurnitureLabel];
    [userSettings setObject:self.model.periodLabel forKey:kSettingsPeriodLabel];
    [userSettings setObject:self.model.additionalyOptionsLabel forKey:kSettingsAdditionalyOptionsLabel];
    
    [userSettings synchronize];
}

- (void)loadSettings
{
    NSUserDefaults* userSettings = [NSUserDefaults standardUserDefaults];
    
    self.model.typeRealtyId = [userSettings integerForKey:kSettingsTypeRealtyId];
    self.model.districtId = [userSettings integerForKey:kSettingsDistrictId];
    self.model.furnitureId = [userSettings integerForKey:kSettingsDistrictId];
    self.model.periodId =[userSettings integerForKey:kSettingsPeriodId];
    self.model.costFrom = [userSettings integerForKey:kSettingsCostFrom];
    self.model.costTo = [userSettings integerForKey:kSettingsCostTo];
    
    self.model.additionalyOptionsIds = [userSettings arrayForKey:kSettingsAdditionalyOptionsIds];
    self.model.typeRealtyLabel = [userSettings stringForKey:kSettingsTypeRealtyLabel];
    self.model.districtLabel = [userSettings stringForKey:kSettingsDistrictLabel];
    self.model.furnitureLabel = [userSettings stringForKey:kSettingsFurnitureLabel];
    self.model.periodLabel = [userSettings stringForKey:kSettingsPeriodLabel];
    self.model.additionalyOptionsLabel = [userSettings stringForKey:kSettingsAdditionalyOptionsLabel];
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath: %@", indexPath);
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"optionsSegue" sender:@{@"testKey": @"testObject"}];
            break;
        case 1:
            [self performSegueWithIdentifier:@"optionsSegue" sender:@{@"testKey": @"testObject"}];
            break;
        case 3:
            [self performSegueWithIdentifier:@"optionsSegue" sender:@{@"testKey": @"testObject"}];
            break;
        case 4:
            [self performSegueWithIdentifier:@"optionsSegue" sender:@{@"testKey": @"testObject"}];
            break;
        case 5:
            [self performSegueWithIdentifier:@"optionsSegue" sender:@{@"testKey": @"testObject"}];
            break;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue");
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

- (IBAction)actionFilterCancel:(UIBarButtonItem *)sender
{
    NSLog(@"actionFilterCancel");
    [self saveSettings];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionFilterApply:(UIBarButtonItem *)sender
{
    NSLog(@"actionFilterApply");
}

- (IBAction)actionChangeCostFormSlider:(UISlider *)sender {
    self.costFromTextField.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

- (IBAction)actionChangeCostToSlider:(UISlider *)sender {
    self.costToTextField.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

@end
