//
//  VVRegionMultiSelectController.m
//  Rentor
//
//  Created by vegera on 15.10.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVRegionMultiSelectController.h"
#import "VVOptionsTableViewCell.h"
#import "VVServerManager.h"
#import "VVDictionary.h"
#import "MBProgressHUD.h"
#import "VVSimpleTopCell.h"

#import "VVRealty.h"

#import "VVSelectPhotoCollectionController.h"

@interface VVRegionMultiSelectController ()

@property (strong, nonatomic) NSString* select;
@property (strong, nonatomic) NSString* keyLabel;
@property (strong, nonatomic) NSString* captionTitle;

@property (strong, nonatomic) VVRealty* model;

@end

@implementation VVRegionMultiSelectController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem* rightSegue = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconNext.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextSegue)];
    self.navigationItem.rightBarButtonItem = rightSegue;
    
    self.title = self.captionTitle;
    
    // change font color for navigation bar
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"PT Sans" size:10], NSFontAttributeName,
                                                                     nil]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; // цвет текста назад
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0];
    
    if ([self.model.type isEqualToString:@"client"]) {
        if (![self.model.whatArray count] > 0) {
            [self loadFromServer];
        }
    } else {
        if (![self.model.whosArray count] > 0) {
            [self loadFromServer];
        }
    }
}

- (void)nextSegue
{
    NSLog(@"nextSegue");
    if ([self.model.type isEqualToString:@"estate"]) {
        [self performSegueWithIdentifier:@"uploadPhotoSegue" sender:@{@"model": self.model,
                                                                      @"captionTitle": @"Выбор фото"}];
    } else {
        NSLog(@"ЗАгружаем клиента");
        [self postServer];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void)postServer
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[VVServerManager sharedManager] postAdvFromModel:self.model
                                            onSuccess:^(id result) {
                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                NSLog(@"onSuccess: %@", result);
                                                [self performSegueWithIdentifier:@"postEndSegue" sender:nil];
                                            }
                                            onFailure:^(NSError *error, NSInteger statusCode) {
                                                NSLog(@"error: %@, statusCode:%d", error, statusCode);
                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                if (statusCode == 666) {
                                                    [self showAlert:@"Отсутствует соединение с интернетом."];
                                                } else {
                                                    [self showAlert:@"Ошибка в передаче данных."];
                                                }
                                                [self performSegueWithIdentifier:@"postEndSegue" sender:nil];
                                            }];
}

- (void)loadFromServer
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[VVServerManager sharedManager] getDictionaryForType:self.select
                                                onSuccess:^(NSArray *dict) {
                                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                    NSLog(@"onSuccess: %@", dict);
                                                    //                                                    self.optionsArray = dict;
                                                    
                                                    if ([self.model.type isEqualToString:@"client"]) {
                                                        self.model.whatArray = [NSMutableArray arrayWithArray:dict];
                                                    } else {
                                                        self.model.whosArray = [NSMutableArray arrayWithArray:dict];
                                                    }
                                                    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 56.f;
    }
    
    return 44.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if ([self.model.type isEqualToString:@"client"]) {
        return [self.model.whatArray count] + 1;
    } else {
        return [self.model.whosArray count] + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString* simpleTopCellIdentifier = @"simpleTopCellIdentifier";
        
        VVSimpleTopCell* cell = [tableView dequeueReusableCellWithIdentifier:simpleTopCellIdentifier];
        
        if (!cell) {
            cell = [[VVSimpleTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTopCellIdentifier];
        }
        
        [cell.iconImageView setImage:cell.stepTwoImage];
        if ([self.model.type isEqualToString:@"client"]) {
            cell.titleLabel.text = @"Шаг. Информация о клиентах";
        } else {
            cell.titleLabel.text = @"Шаг. Информация о квартирах";
        }
        
        return cell;
    }
    
    static NSString* cellOptionsIdentifier = @"optionsCell";
    
    VVDictionary* model;
    
    if ([self.model.type isEqualToString:@"client"]) {
        model = [self.model.whatArray objectAtIndex:indexPath.row - 1];
    } else {
        model = [self.model.whosArray objectAtIndex:indexPath.row - 1];
    }
    
    VVOptionsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellOptionsIdentifier];
    
    if (!cell) {
        cell = [[VVOptionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellOptionsIdentifier];
    }
    
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
    
    VVDictionary* model;
    if ([self.model.type isEqualToString:@"client"]) {
        model = [self.model.whatArray objectAtIndex:indexPath.row - 1];
    } else {
        model = [self.model.whosArray objectAtIndex:indexPath.row - 1];
    }
    
    if (model.selected) {
        [model setSelected:NO];
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"switchOff.png"]]];
    } else {
        [model setSelected:YES];
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"switchOn.png"]]];
    }
    
    NSLog(@"%@, %@", self.select, self.keyLabel);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didDeselectRowAtIndexPath: %@", indexPath);
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@", sender);
    
    if ([[segue identifier] isEqualToString:@"uploadPhotoSegue"]) {
        
        // Get destination view
        VVSelectPhotoCollectionController *vc = [segue destinationViewController];
        
        // Pass the information to your destination view
        [vc setValue:[sender objectForKey:@"model"] forKey:@"model"];
    }
}

@end
