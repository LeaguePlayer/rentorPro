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

@end

@implementation VVCreateRealtyStepOneTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // UIBarButtonItem* rightSegue = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextSegue)];
    UIBarButtonItem* rightSegue = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconNext.png"] style:UIBarButtonItemStylePlain target:self action:@selector(nextSegue)];
    // [rightSegue setImage:[UIImage imageNamed:@"iconNext.png"]];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath: %d", indexPath.row);
    //[tableView cellForRowAtIndexPath:indexPath].selected = NO;
    //[self performSegueWithIdentifier:@"optionsSegue" sender:@{@"testKey": @"testObject"}];
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
        case 5:
            [self actionOptionsSelect];
            break;
        case 6:
            [self actionOptionsSelect];
            break;
        case 7:
            [self actionOptionsSelect];
            break;
        case 8:
            [self actionOptionsSelect];
            break;
        case 9:
            NSLog(@"%d", indexPath.row);
            break;
        case 10:
            NSLog(@"%d", indexPath.row);
            break;
        case 11:
            NSLog(@"%d", indexPath.row);
            break;
        case 12:
            [self actionOptionsSelect];
            break;
            
        default:
            break;
    }
}

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}*/


/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return nil;
}*/


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"prepareForSegue: %@", sender);
    VVOptionsTableViewController *vc = [segue destinationViewController];
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

- (void)refreshAccessory
{
    for (UITableViewCell* cell in self.cellForChangeAccessoryCollection) {
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconSegue.png"]]];
    }
}

- (void)setCheckboxAccessory
{
    for (UITableViewCell* cell in self.cellCheckboxCollection) {
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"switchOn.png"]]];
        UIView* transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 320, 42)];
        [cell setSelectedBackgroundView:transparentView];
    }
}

- (void)cellDesabledSelect
{
    for (UITableViewCell* cell in self.cellForDesabledSelectCollection) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

#pragma mark - ActionsForSegue

- (void)actionShowSelect
{
    NSLog(@"actionShowSelect");
    [self performSegueWithIdentifier:@"optionsSegue" sender:@{@"testKey": @"testObject"}];
}

- (void)actionExpiresSelect
{
    NSLog(@"actionExpiresSelect");
    [self performSegueWithIdentifier:@"optionsSegue" sender:@{@"testKey": @"testObject"}];
}

- (void)actionSuiteSelect
{
    NSLog(@"actionSuiteSelect");
    [self performSegueWithIdentifier:@"optionsSegue" sender:@{@"testKey": @"testObject"}];
}

- (void)actionFurnitureSelect
{
    NSLog(@"actionFurnitureSelect");
    [self performSegueWithIdentifier:@"optionsSegue" sender:@{@"testKey": @"testObject"}];
}

- (void)actionOptionsSelect
{
    NSLog(@"actionOptionsSelect");
    [self performSegueWithIdentifier:@"optionsSegue" sender:@{@"testKey": @"testObject"}];
}

@end
