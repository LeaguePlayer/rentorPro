//
//  VVDetailAdvTableViewController.m
//  rentor
//
//  Created by vegera on 30.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVDetailAdvTableViewController.h"
#import "VVserverManager.h"
#import "VVRealty.h"

#import "MBProgressHUD.h"

@interface VVDetailAdvTableViewController ()

@property (assign, nonatomic) NSInteger recordID; // передаем id объявления для загрузки данных

@property (weak, nonatomic) IBOutlet UILabel *articleLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeAdvLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusAdvLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateChangeAdvLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *countPhotoLabel;
@property (weak, nonatomic) IBOutlet UILabel *furtitureLabel;
@property (weak, nonatomic) IBOutlet UILabel *communePaymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *prepaymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodRentLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *countRoomLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *countMutualAdvLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (strong, nonatomic) VVRealty* model; // в моделе хранятся все данные и в нее первоначально грузятся данные, в общем все на ней

@property (strong, nonatomic) NSArray* photos; // временная переменная с фотками

@end

@implementation VVDetailAdvTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self refreshAccessory];
}

- (void)setValueForLabel
{
    [self.articleLabel setText:[self.model article]];
    [self.typeAdvLabel setText:[self.model typeAdv]];
    [self.statusAdvLabel setText:[self.model status]];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d.M.Y h:m"];
    [self.dateChangeAdvLabel setText:[dateFormatter stringFromDate:[self.model changeDateTime]]];
    [self.costLabel setText:[NSString stringWithFormat:@"%d", [self.model cost]]];
    [self.districtLabel setText:[self.model district]];
    [self.ownerLabel setText:[NSString stringWithFormat:@"%@ +7%@", [self.model rieltorName], [self.model phoneNumber]]];
    [self.countPhotoLabel setText:[NSString stringWithFormat:@"%d штук(а)", [[self.model photoArray] count] ]];
    [self.furtitureLabel setText:[self.model furniture]];
    [self.communePaymentLabel setText:[self.model communePayment]];
    [self.stateLabel setText:[self.model state]];
    [self.prepaymentLabel setText:[self.model prepayment]];
    [self.periodRentLabel setText:[self.model period]];
    [self.serialNumberLabel setText:[self.model serialNumber]];
    [self.countRoomLabel setText:[self.model countRoom]];
    [self.optionsLabel setText:[self.model options]];
    [self.conditionLabel setText:[self.model condition]];
    [self.countMutualAdvLabel setText:[NSString stringWithFormat:@"%d штук", [[self.model mutualAdv] count]]];
    [self.commentLabel setText:[self.model publicComment]];
}

- (void)loadFromServer
{
    [[VVServerManager sharedManager] getAdvertisingForId:[self recordID]
                                               onSuccess:^(VVRealty* advertising) {
                                                   NSLog(@"loadFromServer success!");
                                                   self.model = advertising;
                                                   [self setValueForLabel];
                                               }
                                               onFailure:^(NSError *error, NSInteger statusCode) {
                                                   NSLog(@"error: %@ statusCode: %d", error, statusCode);
                                               }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath: %@", indexPath);
    switch (indexPath.row) {
        case 6:
            [self showAlertForCallPhoneNumber];
            break;
        case 7:
            [self showPhotosForAdvertising];
            break;
        case 18:
            NSLog(@"18"); // mutualAdvSegue
            [self performSegueWithIdentifier:@"mutualAdvSegue" sender:@{@"testKey": @"testObject"}];
            break;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"prepareForSegue");
}

#pragma mark - Accessory

- (void)refreshAccessory
{
    for (UITableViewCell* cell in self.cellForChangeAccessoryCollection) {
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconSegue.png"]]];
    }
}

#pragma mark - callPhone

- (void)showAlertForCallPhoneNumber
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Заголовок"
                          message:@"Позвонить сейчас?"
                          delegate:self  // set nil if you don't want the yes button callback
                          cancelButtonTitle:@"Да"
                          otherButtonTitles:@"Нет", nil];
    [alert show];
}

- (void)callPhone:(NSString *)phoneNumber
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNumber]];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // do code for yes click
        [self callPhone:@"+79829421709" /*[self.model phoneNumber]*/];
    } else {
        // otherwise
        NSLog(@"NO");
    }
}

#pragma mark - MWPhotoBrowserDelegate

- (void)loadPhotoFromServer // метод временный, не уверен что он должен жить, его нужно будет в модель перенести, чтобы контейнил MWPhoto
{
    NSArray* photos = @[
                        [MWPhoto photoWithURL:[NSURL URLWithString:@"http://cs540101.vk.me/c540102/v540102134/a737d/NprsfpQjhAQ.jpg"]],
                        [MWPhoto photoWithURL:[NSURL URLWithString:@"http://cs540101.vk.me/c540102/v540102134/a736b/iDHabTfJML4.jpg"]],
                        [MWPhoto photoWithURL:[NSURL URLWithString:@"http://cs540101.vk.me/c540102/v540102134/a7349/SuGNjzK0ZUk.jpg"]],
                        [MWPhoto photoWithURL:[NSURL URLWithString:@"http://cs540101.vk.me/c540102/v540102134/a7142/DNaWSNLvQeI.jpg"]],
                        [MWPhoto photoWithURL:[NSURL URLWithString:@"http://cs540101.vk.me/c540102/v540102134/a7103/0etvheAnvw4.jpg"]]];
    self.photos = photos;
}

- (void)showPhotosForAdvertising
{
    // Create array of MWPhoto objects
    [self loadPhotoFromServer];
    
    // Create browser (must be done each time photo browser is
    // displayed. Photo browser objects cannot be re-used)
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.wantsFullScreenLayout = YES; // iOS 5 & 6 only: Decide if you want the photo browser full screen, i.e. whether the status bar is affected (defaults to YES)
    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:1];
    
    // Present
    [self.navigationController pushViewController:browser animated:YES];
    
    // Manipulate
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    [browser setCurrentPhotoIndex:0];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}

@end
