//
//  VVFilterTableViewController.m
//  rentor
//
//  Created by vegera on 29.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVFilterTableViewController.h"
#import "VVFilterModel.h"
#import "VVAdvertisingsAndClientsViewController.h"
#import "VVOptionsTableViewController.h"

@interface VVFilterTableViewController ()

@property (strong, nonatomic) VVFilterModel* model;

@property (strong, nonatomic) NSDictionary *typeDictionary;
@property (strong, nonatomic) NSDictionary *districtDictionary;
@property (strong, nonatomic) NSDictionary *furnitureDictionary;
@property (strong, nonatomic) NSDictionary *periodDictionary;
@property (strong, nonatomic) NSDictionary *additionalOptionsDictionary;

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

static NSString* notificationKey = @"filterNotification";
static NSString* textLabel = @"textLabel";

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

- (void)resetSettings
{
    self.costFromSlider.value = 2000.f;
    self.costToSlider.value = 2000.f;
    self.costFromTextField.text = @"2000";
    self.costToTextField.text = @"2000";
    self.type.text =
    self.district.text =
    self.furniture.text =
    self.period.text =
    self.additionalOptions.text = @"выбрать";
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath: %@", indexPath);
    
    [self.tableView endEditing:YES]; // hide keyboard
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"optionsSegue"
                                      sender:@{@"select": @"", //TODO: указать фильтр для загрузки с сервера
                                               @"keyLabel": @"typeDictionary",
                                               @"captionTitle": @"Тип недвижимости"}];
            break;
        case 1:
            [self performSegueWithIdentifier:@"optionsSegue"
                                      sender:@{@"select": @"", //TODO: указать фильтр для загрузки с сервера
                                               @"keyLabel": @"districtDictionary",
                                               @"captionTitle": @"Район"}];
            break;
        case 3:
            [self performSegueWithIdentifier:@"optionsSegue"
                                      sender:@{@"select": @"", //TODO: указать фильтр для загрузки с сервера
                                               @"keyLabel": @"furnitureDictionary",
                                               @"captionTitle": @"Мебель"}];
            break;
        case 4:
            [self performSegueWithIdentifier:@"optionsSegue"
                                      sender:@{@"select": @"", //TODO: указать фильтр для загрузки с сервера
                                               @"keyLabel": @"periodDictionary",
                                               @"captionTitle": @"Срок"}];
            break;
        case 5:
            [self performSegueWithIdentifier:@"optionsSegue"
                                      sender:@{@"select": @"", //TODO: указать фильтр для загрузки с сервера
                                               @"keyLabel": @"additionalOptionsDictionary",
                                               @"captionTitle": @"Доп условия"}];
            break;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue");
    
    if ([[segue identifier] isEqualToString:@"optionsSegue"]) {
        
        // Get destination view
        VVOptionsTableViewController *vc = [segue destinationViewController];
        
        // Pass the information to your destination view
        [vc setValue:[sender objectForKey:@"select"] forKey:@"select"];
        [vc setValue:[sender objectForKey:@"keyLabel"] forKey:@"keyLabel"];
        [vc setValue:[sender objectForKey:@"captionTitle"] forKey:@"captionTitle"];
    }
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

#pragma mark - NotificationCenter

- (void)sendFilterWithNotificationCenter
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationKey object:@{@"key":@"value"}]; // передаем список фильтров
}

#pragma mark - Actions

- (IBAction)actionFilterCancel:(UIBarButtonItem *)sender
{
    NSLog(@"actionFilterCancel");
    
    [self saveSettings];
    [self sendFilterWithNotificationCenter];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionFilterApply:(UIBarButtonItem *)sender
{
    NSLog(@"actionFilterApply");
    [self resetSettings];
}

- (IBAction)actionChangeCostFormSlider:(UISlider *)sender {
    self.costFromTextField.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

- (IBAction)actionChangeCostFromTextField:(UITextField *)sender forEvent:(UIEvent *)event {
    NSLog(@"actionChangeCostFromTextField: %@", self.costFromTextField.text);
    self.costFromSlider.value = (int)self.costFromTextField.text;
    
    if (self.costFromSlider.value > self.costToSlider.value) {
        [self.costToSlider setValue:self.costFromSlider.value animated:YES];
    }
}

- (IBAction)actionChangeCostToSlider:(UISlider *)sender {
    self.costToTextField.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

- (IBAction)actionChangeCostToTextField:(UITextField *)sender forEvent:(UIEvent *)event {
    NSLog(@"actionChangeCostToTextField: %@", self.costToTextField.text);
    self.costToSlider.value = (int)self.costToTextField.text;
    
    if (self.costToSlider.value < self.costFromSlider.value) {
        [self.costFromSlider setValue:self.costToSlider.value animated:YES];
    }
}

#pragma mark - Setters

- (void)setTypeDictionary:(NSDictionary *)typeDictionary {
    self.type.text = [typeDictionary objectForKey:textLabel];
    //TODO: сделать запись в модель, может быть переделать в словарь вместо строки
}

- (void)setDistrictDictionary:(NSDictionary *)districtDictionary {
    self.district.text = [districtDictionary objectForKey:textLabel];
    //TODO: сделать запись в модель, может быть переделать в словарь вместо строки
}

- (void)setFurnitureDictionary:(NSDictionary *)furnitureDictionary {
    self.furniture.text = [furnitureDictionary objectForKey:textLabel];
    //TODO: сделать запись в модель, может быть переделать в словарь вместо строки
}

- (void)setPeriodString:(NSString *)periodString
{
    self.period.text = periodString;
    //TODO: сделать запись в модель, может быть переделать в словарь вместо строки
}

-(void)setPeriodDictionary:(NSDictionary *)periodDictionary {
    self.period.text = [periodDictionary objectForKey:textLabel];
    //TODO: сделать запись в модель, может быть переделать в словарь вместо строки
}

-(void)setAdditionalOptionsDictionary:(NSDictionary *)additionalOptionsDictionary {
    self.additionalOptions.text = [additionalOptionsDictionary objectForKey:textLabel];
    //TODO: сделать запись в модель, может быть переделать в словарь вместо строки
}

@end
