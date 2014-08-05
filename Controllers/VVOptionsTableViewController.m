//
//  VVOptionsTableViewController.m
//  rentor
//
//  Created by vegera on 28.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVOptionsTableViewController.h"
#import "VVOptionsTableViewCell.h"

@interface VVOptionsTableViewController ()

@property (strong, nonatomic) NSString* select;
@property (strong, nonatomic) NSString* keyLabel;
@property (strong, nonatomic) NSString* captionTitle;

/*
NSDictionary* dict = @{@"select": @"show", // с этим ключем делается запрос на сервер
@"keyStringForModel": @"show", // поле в моделе, которое нужно записать
@"keyLabel": @"showLabel"}; // лейбл в который нужно будет передать текст выбранного селекта
*/

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
    // TODO: get query to server
//    self.select опция для загрузки словаря для выбора значения
    self.optionsArray = @[@{@"id": @"12", @"selected": @"NO", @"title": @"Женщина"},
                          @{@"id": @"12", @"selected": @"NO", @"title": @"Две женщины"},
                          @{@"id": @"12", @"selected": @"NO", @"title": @"Семья"},
                          @{@"id": @"12", @"selected": @"NO", @"title": @"Организация"},
                          @{@"id": @"12", @"selected": @"NO", @"title": @"Мужчина"},
                          @{@"id": @"12", @"selected": @"NO", @"title": @"Двое мужчин"},
                          @{@"id": @"12", @"selected": @"NO", @"title": @"Одинокие"},
                          @{@"id": @"12", @"selected": @"NO", @"title": @"Рабочие"},
                          @{@"id": @"12", @"selected": @"NO", @"title": @"С мал.детьми"},
                          @{@"id": @"12", @"selected": @"NO", @"title": @"С животными"},
                          @{@"id": @"12", @"selected": @"NO", @"title": @"Не русские"}];
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
    
    if ([[[self.optionsArray objectAtIndex:indexPath.row] objectForKey:@"selected"] isEqualToString:@"YES"]) {
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"switchOn.png"]]];
    } else {
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"switchOff.png"]]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text = [[self.optionsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath: %@", indexPath);
    VVOptionsTableViewCell* cell = (VVOptionsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"switchOn.png"]]];
    
    NSLog(@"%@, %@", self.select, self.keyLabel);
    [[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 2] setValue:@{textLabel:[[self.optionsArray objectAtIndex:indexPath.row] objectForKey:@"title"]} forKey:self.keyLabel];
    NSLog(@"%@",[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 2]);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didDeselectRowAtIndexPath: %@", indexPath);
    VVOptionsTableViewCell* cell = (VVOptionsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"switchOff.png"]]];
}

@end
