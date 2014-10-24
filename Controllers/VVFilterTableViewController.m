//
//  VVFilterTableViewController.m
//  rentor
//
//  Created by vegera on 29.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVFilterTableViewController.h"
#import "VVAdvertisingsAndClientsViewController.h"
#import "VVOptionsTableViewController.h"

@interface VVFilterTableViewController ()

@property (strong, nonatomic) NSDictionary *typeDictionary;
@property (strong, nonatomic) NSDictionary *districtDictionary;
@property (strong, nonatomic) NSDictionary *furnitureDictionary;
@property (strong, nonatomic) NSDictionary *periodDictionary;
@property (strong, nonatomic) NSDictionary *additionalOptionsDictionary;

@end

static NSString* notificationKey = @"filterNotification";
static NSString* textLabel = @"textLabel";

@implementation VVFilterTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refreshAccessory];
    [self cellDesabledSelect];
    [self textFieldInit];
    [self loadFilter];
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

#pragma mark - Settings

- (void)loadFilter
{
    if (_model.what_label) {
        self.type.text = _model.what_label;
    }
    
    if (_model.furniture_label) {
        self.furniture.text = _model.furniture_label;
    }
    
    if (_model.priceFrom) {
        self.costFromSlider.value = [_model.priceFrom floatValue];
        self.costFromTextField.text = _model.priceFrom;
    }
    
    if (_model.priceTo) {
        self.costToSlider.value = [_model.priceTo floatValue];
        self.costToTextField.text = _model.priceTo;
    }
    
    if (_model.region_label) {
        self.district.text = _model.region_label;
    }
    
    if (_model.period_label) {
        self.period.text = _model.period_label;
    }
    
    if (_model.option_label) {
        self.additionalOptions.text = _model.option_label;
    }
}

- (void)resetSettings
{
    self.costFromSlider.value = 2000.f;
    self.costToSlider.value = 40000.f;
    self.costFromTextField.text = @"2000";
    self.costToTextField.text = @"40000";
    self.type.text =
    self.district.text =
    self.furniture.text =
    self.period.text =
    self.additionalOptions.text = @"выбрать";
    
    self.model.what_id =
    self.model.what_label =
    self.model.region_id =
    self.model.region_label =
    self.model.furniture_id =
    self.model.furniture_label =
    self.model.period_id =
    self.model.period_label =
    self.model.option_id =
    self.model.option_label = nil;
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath: %@", indexPath);
    
    [self.tableView endEditing:YES]; // hide keyboard
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"optionsSegue"
                                      sender:@{@"select": @"whats",
                                               @"keyLabel": @"typeDictionary",
                                               @"captionTitle": @"Тип недвижимости"}];
            break;
        case 1:
            [self performSegueWithIdentifier:@"optionsSegue"
                                      sender:@{@"select": @"regions",
                                               @"keyLabel": @"districtDictionary",
                                               @"captionTitle": @"Район"}];
            break;
        case 3:
            [self performSegueWithIdentifier:@"optionsSegue"
                                      sender:@{@"select": @"furnitures",
                                               @"keyLabel": @"furnitureDictionary",
                                               @"captionTitle": @"Мебель"}];
            break;
        case 4:
            [self performSegueWithIdentifier:@"optionsSegue"
                                      sender:@{@"select": @"periods",
                                               @"keyLabel": @"periodDictionary",
                                               @"captionTitle": @"Срок"}];
            break;
        case 5:
            [self performSegueWithIdentifier:@"optionsSegue"
                                      sender:@{@"select": @"options",
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
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationKey object:@{@"model":self.model, @"filter":self.keyForNotification}]; // передаем список фильтров
}

#pragma mark - Actions

- (IBAction)actionFilterCancel:(UIBarButtonItem *)sender
{
    NSLog(@"actionFilterCancel");
    
    [self sendFilterWithNotificationCenter];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionFilterApply:(UIBarButtonItem *)sender
{
    NSLog(@"actionFilterApply");
    [self resetSettings];
}

- (IBAction)actionChangeCostFormSlider:(UISlider *)sender {
    self.model.priceFrom =
    self.costFromTextField.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

- (IBAction)actionChangeCostFromTextField:(UITextField *)sender forEvent:(UIEvent *)event {
    NSLog(@"actionChangeCostFromTextField: %@", self.costFromTextField.text);
    self.model.priceFrom = self.costFromTextField.text;
    self.costFromSlider.value = (int)self.costFromTextField.text;
    
    if (self.costFromSlider.value > self.costToSlider.value) {
        [self.costToSlider setValue:self.costFromSlider.value animated:YES];
    }
}

- (IBAction)actionChangeCostToSlider:(UISlider *)sender {
    self.model.priceTo =
    self.costToTextField.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

- (IBAction)actionChangeCostToTextField:(UITextField *)sender forEvent:(UIEvent *)event {
    NSLog(@"actionChangeCostToTextField: %@", self.costToTextField.text);
    self.model.priceTo = self.costToTextField.text;
    self.costToSlider.value = (int)self.costToTextField.text;
    
    if (self.costToSlider.value < self.costFromSlider.value) {
        [self.costFromSlider setValue:self.costToSlider.value animated:YES];
    }
}

#pragma mark - Setters

- (void)setTypeDictionary:(NSDictionary *)typeDictionary {
    self.model.what_id = [typeDictionary objectForKey:@"id"];
    self.model.what_label =
    self.type.text = [typeDictionary objectForKey:textLabel];
}

- (void)setDistrictDictionary:(NSDictionary *)districtDictionary {
    self.model.region_id = [districtDictionary objectForKey:@"id"];
    self.model.region_label =
    self.district.text = [districtDictionary objectForKey:textLabel];
}

- (void)setFurnitureDictionary:(NSDictionary *)furnitureDictionary {
    self.model.furniture_id = [furnitureDictionary objectForKey:@"id"];
    self.model.furniture_label =
    self.furniture.text = [furnitureDictionary objectForKey:textLabel];
}

-(void)setPeriodDictionary:(NSDictionary *)periodDictionary {
    self.model.period_id = [periodDictionary objectForKey:@"id"];
    self.model.period_label =
    self.period.text = [periodDictionary objectForKey:textLabel];
}

-(void)setAdditionalOptionsDictionary:(NSDictionary *)additionalOptionsDictionary {
    self.model.option_id = [additionalOptionsDictionary objectForKey:@"id"];
    self.model.option_label =
    self.additionalOptions.text = [additionalOptionsDictionary objectForKey:textLabel];
}

@end
