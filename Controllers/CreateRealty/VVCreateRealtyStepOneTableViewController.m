//
//  VVCreateRealtyStepOneTableViewController.m
//  rentor
//
//  Created by vegera on 28.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVCreateRealtyStepOneTableViewController.h"
#import "VVOptionsTableViewController.h"
#import "VVRealty.h"

@interface VVCreateRealtyStepOneTableViewController ()

@property (strong, nonatomic) VVRealty* model;

@property (strong, nonatomic) NSDictionary* showDictionary;
@property (strong, nonatomic) NSDictionary* expiresDictionary;
@property (strong, nonatomic) NSDictionary* suiteDictionary;
@property (strong, nonatomic) NSDictionary* furnitureDictionary;
@property (strong, nonatomic) NSDictionary* districtDictionary;
@property (strong, nonatomic) NSDictionary* periodDictionary;

@end

static NSString* textLabel = @"textLabel";

@implementation VVCreateRealtyStepOneTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem* rightSegue = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconNext.png"] style:UIBarButtonItemStylePlain target:self action:@selector(nextSegue)];
    self.navigationItem.rightBarButtonItem = rightSegue;
    
    [self textFieldInit];
    [self textViewInit];
    [self refreshAccessory];
    [self setCheckboxAccessory];
    [self cellDesabledSelect];
}

- (void)nextSegue
{
    NSLog(@"nextSegue");
    [self performSegueWithIdentifier:@"optionsSegue" sender:@{@"testKey": @"testObject"}];
}

- (void)textFieldInit
{
    self.costTextField.frame = CGRectMake(180, 19, 117, 44);
}

- (void)textViewInit
{
    //To make the border look very close to a UITextField
    [self.publicCommentTextField.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.publicCommentTextField.layer setBorderWidth:0.5];
    
    //The rounded corner part, where you specify your view's corner radius:
    self.publicCommentTextField.layer.cornerRadius = 5;
    self.publicCommentTextField.clipsToBounds = YES;
    
    //To make the border look very close to a UITextField
    [self.privateCommentTextField.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.privateCommentTextField.layer setBorderWidth:0.5];
    
    //The rounded corner part, where you specify your view's corner radius:
    self.privateCommentTextField.layer.cornerRadius = 5;
    self.privateCommentTextField.clipsToBounds = YES;
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath: %d", indexPath.row);
    
    [self.tableView endEditing:YES];
    
    switch (indexPath.row) {
        case 1:
            [self actionShowSelect];
            break;
        case 2:
            [self actionExpiresSelect];
            break;
        case 3:
            [self actionSuiteSelect];
            break;
        case 4:
            [self actionFurnitureSelect];
            break;
//        case 5:
//            [self actionOptionsSelect];
//            break;
        case 6:
            [self actionPeriodSelect];
            break;
//        case 7:
//            [self actionOptionsSelect];
//            break;
        case 8:
            NSLog(@"%d", indexPath.row);
            break;
        case 9:
            NSLog(@"%d", indexPath.row);
            break;
        case 10:
            NSLog(@"%d", indexPath.row);
            break;
        case 11:
            [self actionDistrictSelect];
            break;
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@", sender);
    
    if ([[segue identifier] isEqualToString:@"optionsSegue"]) {
        
        // Get destination view
        VVOptionsTableViewController *vc = [segue destinationViewController];
        
        // Pass the information to your destination view
        [vc setValue:[sender objectForKey:@"select"] forKey:@"select"];
        [vc setValue:[sender objectForKey:@"keyLabel"] forKey:@"keyLabel"];
        [vc setValue:[sender objectForKey:@"captionTitle"] forKey:@"captionTitle"];
    }
}

#pragma mark - Actions

- (IBAction)menuButtonTapped:(id)sender
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (IBAction)actionChangeCostFromTextField:(UITextField *)sender forEvent:(UIEvent *)event
{
    //
}

- (IBAction)actionChangeCostFromSlider:(UISlider *)sender forEvent:(UIEvent *)event
{
    self.costTextField.text = [NSString stringWithFormat:@"%d", (int)sender.value];
    self.model.cost = (NSInteger)sender.value;
}

#pragma mark - Accessory

- (void)refreshAccessory {
    for (UITableViewCell* cell in self.cellForChangeAccessoryCollection) {
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconSegue.png"]]];
    }
}

- (void)setCheckboxAccessory {
    for (UITableViewCell* cell in self.cellCheckboxCollection) {
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"switchOn.png"]]];
        UIView* transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 320, 42)];
        [cell setSelectedBackgroundView:transparentView];
    }
}

- (void)cellDesabledSelect {
    for (UITableViewCell* cell in self.cellForDesabledSelectCollection) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

#pragma mark - ActionsForSegue

- (void)actionShowSelect
{
    NSLog(@"actionShowSelect");
    NSDictionary* dict = @{@"select": @"show",
                           @"keyLabel": @"showDictionary",
                           @"captionTitle": @"Доступно"};
    [self performSegueWithIdentifier:@"optionsSegue" sender:dict];
}

- (void)actionExpiresSelect
{
    NSDictionary* dict = @{@"select": @"expires",
                           @"keyLabel": @"expiresDictionary",
                           @"captionTitle": @"Размещение"};
    NSLog(@"actionExpiresSelect");
    [self performSegueWithIdentifier:@"optionsSegue" sender:dict];
}

- (void)actionSuiteSelect
{
    NSLog(@"actionSuiteSelect");
    NSDictionary* dict = @{@"select": @"suite",
                           @"keyLabel": @"suiteDictionary",
                           @"captionTitle": @"Серия дома"};
    [self performSegueWithIdentifier:@"optionsSegue" sender:dict];
}

- (void)actionFurnitureSelect
{
    NSLog(@"actionFurnitureSelect");
    NSDictionary* dict = @{@"select": @"", //TODO: указать фильтр для загрузки с сервера
                           @"keyLabel": @"furnitureDictionary",
                           @"captionTitle": @"Мебель"};
    [self performSegueWithIdentifier:@"optionsSegue" sender:dict];
}

- (void)actionDistrictSelect
{
    NSLog(@"actionOptionsSelect");
    NSDictionary* dict = @{@"select": @"", //TODO: указать фильтр для загрузки с сервера
                           @"keyLabel": @"districtDictionary",
                           @"captionTitle": @"Район"};
    [self performSegueWithIdentifier:@"optionsSegue" sender:dict];
}

- (void)actionPeriodSelect
{
    NSLog(@"actionPeriodSelect");
    NSDictionary* dict = @{@"select": @"", //TODO: указать фильтр для загрузки с сервера
                           @"keyLabel": @"periodDictionary",
                           @"captionTitle": @"Срок"};
    [self performSegueWithIdentifier:@"optionsSegue" sender:dict];
}

#pragma mark - Setters

- (void)setShowDictionary:(NSDictionary *)showDictionary {
    self.show.text = [showDictionary objectForKey:textLabel];
    //TODO: обновляем модель  с данными
}

- (void)setExpiresDictionary:(NSDictionary *)expiresDictionary {
    self.expires.text = [expiresDictionary objectForKey:textLabel];
    //TODO: обновляем модель  с данными
}

- (void)setSuiteDictionary:(NSDictionary *)suiteDictionary {
    self.suite.text = [suiteDictionary objectForKey:textLabel];
    //TODO: обновляем модель  с данными
}

- (void)setFurnitureDictionary:(NSDictionary *)furnitureDictionary {
    self.furniture.text = [furnitureDictionary objectForKey:textLabel];
    //TODO: обновляем модель  с данными
}

- (void)setDistrictDictionary:(NSDictionary *)districtDictionary {
    self.districtLabel.text = [districtDictionary objectForKey:textLabel];
    //TODO: обновляем модель  с данными
}

- (void)setPeriodDictionary:(NSDictionary *)periodDictionary {
    self.periodLabel.text = [periodDictionary objectForKey:textLabel];
    //TODO: обновляем модель  с данными
}

@end
