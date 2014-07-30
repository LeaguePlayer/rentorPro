//
//  VVMainAdvViewController.m
//  rentor
//
//  Created by vegera on 30.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVMainAdvViewController.h"

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
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@Cell", [self currentTab]] forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@Cell", [self currentTab]]];
    }
    
    cell.textLabel.text = @"1234";
    
    return cell;
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
