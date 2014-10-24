//
//  VVOptionsTableViewController.m
//  rentor
//
//  Created by vegera on 28.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVOptionsTableViewController.h"
#import "VVOptionsTableViewCell.h"
#import "VVServerManager.h"
#import "VVDictionary.h"
#import "MBProgressHUD.h"

@interface VVOptionsTableViewController ()

@property (strong, nonatomic) NSString* select;
@property (strong, nonatomic) NSString* keyLabel;
@property (strong, nonatomic) NSString* captionTitle;
@property (strong, nonatomic) NSIndexPath* indexPath;
@property (strong, nonatomic) NSString* modelField;

@end

static NSString* textLabel = @"textLabel";

@implementation VVOptionsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.captionTitle;
    
    // change font color for navigation bar
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"PT Sans" size:10], NSFontAttributeName,
                                                                     nil]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; // цвет текста назад
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0];
    
    [self loadFromServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void)loadFromServer
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[VVServerManager sharedManager] getDictionaryForType:self.select
                                                onSuccess:^(NSArray *dict) {
                                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                    NSLog(@"onSuccess: %@", dict);
                                                    self.optionsArray = dict;
                                                    [self.tableView reloadData];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.optionsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellOptionsIdentifier = @"optionsCell";
    
    VVOptionsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellOptionsIdentifier];
    
    if (!cell) {
        cell = [[VVOptionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellOptionsIdentifier];
    }
    
    VVDictionary* model = [self.optionsArray objectAtIndex:indexPath.row];
    
    if (model.selected) {
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"switchOn.png"]]];
    } else {
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"switchOff.png"]]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text = model.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath: %@", indexPath);
    VVOptionsTableViewCell* cell = (VVOptionsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"switchOn.png"]]];
    
    VVDictionary* model = [self.optionsArray objectAtIndex:indexPath.row];
    
    NSLog(@"%@, %@", self.select, self.keyLabel);
    NSLog(@"%@",[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 2]);
    [[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 2] setValue:@{textLabel:model.title, @"id":model.id, @"indexPath": (self.indexPath)? self.indexPath :@"", @"modelField": (self.modelField)? self.modelField: @""} forKey:self.keyLabel];
    
    // как только пользователь выбрал нужный вариант - редиректим его с этого экрана
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didDeselectRowAtIndexPath: %@", indexPath);
    VVOptionsTableViewCell* cell = (VVOptionsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"switchOff.png"]]];
}

- (IBAction)actionNavigationBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
