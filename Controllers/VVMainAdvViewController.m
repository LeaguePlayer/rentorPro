//
//  VVMainAdvViewController.m
//  rentor
//
//  Created by vegera on 30.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVMainAdvViewController.h"
#import "VVMainAdvTableViewCell.h"

@interface VVMainAdvViewController ()

@property (strong, nonatomic) NSArray* allAdvertisingArray; // все
@property (strong, nonatomic) NSArray* realtyArray; // недвижимость
@property (strong, nonatomic) NSArray* clientsArray; // клиенты
@property (strong, nonatomic) NSArray* rentedArray; // сдано/снято

@property (strong, nonatomic) NSString* currentTab; // code current tab

@end

@implementation VVMainAdvViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setCurrentTab:@"allAdvertisingArray"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - API

- (void)loadFromServer
{
    self.allAdvertisingArray = @[@{@"123":@"456"}];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10; // [[self valueForKey:[self currentTab]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellRealtyIdentifier = @"MainAdvTableViewCell";
    
    VVMainAdvTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellRealtyIdentifier];
    
    if (!cell) {
        cell = [[VVMainAdvTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellRealtyIdentifier];
        NSLog(@"create cell");
    } else {
        NSLog(@"reuse cell");
    }
    
    cell.countRoomLabel.text = @"4";
    cell.titleLabel.text = @"Беляевский район, окраина за 9 000 руб";
    cell.roomLabel.text = @"комнаты";
    
    return cell;
}

#pragma mark - Actions

- (IBAction)menuButtonTapped:(id)sender
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (IBAction)actionChangeTab:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            [self setCurrentTab:@"allAdvertisingArray"];
            break;
        case 2:
            [self setCurrentTab:@"realtyArray"];
            break;
        case 3:
            [self setCurrentTab:@"clientsArray"];
            break;
        case 4:
            [self setCurrentTab:@"rentedArray"];
            break;
    }
    NSLog(@"actionChangeTab: %d", sender.tag);
    NSLog(@"%@", [self currentTab]);
}

@end
