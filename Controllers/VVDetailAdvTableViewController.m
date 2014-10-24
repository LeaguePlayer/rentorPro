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

#import "VVDetailStaticTitleWithDescriptionCell.h"
#import "VVDetailWithSegueCell.h"
#import "VVCallCell.h"

@interface VVDetailAdvTableViewController ()

@property (strong, nonatomic) NSArray* tableData;

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

static NSString* detailStaticTitleWithDescriptionCell = @"detailStaticTitleWithDescriptionCell";
static NSString* detailWithSegueCell = @"detailWithSegueCell";
static NSString* callCell = @"callCell";

@implementation VVDetailAdvTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTableData];
}

- (void)setValueForLabel
{
    [self.articleLabel setText:[self.model article]];
    [self.typeAdvLabel setText:[self.model getTypeString]];
    [self.statusAdvLabel setText:[self.model status]];
    
    
//    [self.dateChangeAdvLabel setText:[self.model ]];
    [self.costLabel setText:[self.model price]];
    [self.districtLabel setText:[self.model region]];
    [self.ownerLabel setText:[self.model getRieltor]];
    [self.countPhotoLabel setText:[NSString stringWithFormat:@"%d штук(а)", [[self.model photos] count] ]];
    [self.furtitureLabel setText:[self.model furniture]];
    [self.communePaymentLabel setText:[self.model commune]];
    [self.stateLabel setText:[self.model state]];
    [self.prepaymentLabel setText:[self.model prepay]];
    [self.periodRentLabel setText:[self.model period]];
    [self.serialNumberLabel setText:[self.model suite]];
    [self.countRoomLabel setText:[self.model what]];
//    [self.optionsLabel setText:[self.model options]];
    [self.conditionLabel setText:[self.model condition]];
    [self.countMutualAdvLabel setText:[NSString stringWithFormat:@"%d штук", [[self.model mutualAdv] count]]];
    [self.commentLabel setText:[self.model comment_public]];
}

- (void)loadFromServer
{
    [[VVServerManager sharedManager] getAdvertisingForId:[self recordID]
                                               onSuccess:^(VVRealty* advertising) {
                                                   NSLog(@"loadFromServer success!");
                                                   self.model = advertising;
//                                                   [self setValueForLabel];
                                               }
                                               onFailure:^(NSError *error, NSInteger statusCode) {
                                                   NSLog(@"error: %@ statusCode: %d", error, statusCode);
                                               }];
}

- (void)initTableData
{
    NSMutableArray* field = [NSMutableArray array];
    
    if (self.model.article) {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Артикул",
                           @"value": [self.model article]}];
    }
    
    [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                       @"title": @"Тип объявления",
                       @"value": [self.model getTypeString]}];
    
    if ([self.model what]) {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Что",
                           @"value": [self.model what]}];
    }
    
    if ([self.model price]) {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Цена",
                           @"value": [self.model price]}];
    }
    
    if ([self.model region]) {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Район",
                           @"value": [self.model region]}];
    }
    
    [field addObject:@{@"type": callCell,
                       @"title": @"Риэлтор",
                       @"value": [self.model getRieltor]}];
    
    if ([[self.model photos] count] > 0) {
        [field addObject:@{@"type": detailWithSegueCell,
                           @"title": @"Фотографии",
                           @"value": [NSString stringWithFormat:@"%d штук(а)", [[self.model photos] count] ]}];
    }
    
    if ([self.model furniture]) {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Мебель",
                           @"value": [self.model furniture]}];
    } else {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Мебель",
                           @"value": @"Не указано"}];
    }
    
    if ([self.model period] && ![[self.model period] isEqual:[NSNull null]]) {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Срок сдачи",
                           @"value": [self.model period]}];
    } else {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Срок сдачи",
                           @"value": @"Не указано"}];
    }
    
    if ([self.model suite]) {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Серия дома",
                           @"value": [self.model suite]}];
    } else {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Серия дома",
                           @"value": @"Не указано"}];
    }
    
    if ([self.model prepay]) {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Предоплата",
                           @"value": [self.model prepay]}];
    } else {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Предоплата",
                           @"value": @"Не указано"}];
    }
    
    if ([self.model condition]) {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Условия",
                           @"value": [self.model condition]}];
    } else {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Условия",
                           @"value": @"Не указано"}];
    }
    
    if ([self.model whos]) {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Кому",
                           @"value": [self.model whos]}];
    } else {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Кому",
                           @"value": @"Не указано"}];
    }
    
    if ([self.model commune]) {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Комунальные платежи",
                           @"value": [self.model commune]}];
    } else {
        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
                           @"title": @"Комунальные платежи",
                           @"value": @"Не указано"}];
    }
    
//    if ([self.model ]) {
//        [field addObject:@{@"type": detailStaticTitleWithDescriptionCell,
//                           @"title": @"Примечание",
//                           @"value": @"user"}];
//    }
    
    self.tableData = field;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* defaultCell;
    NSDictionary* dict = [self.tableData objectAtIndex:indexPath.row];
    
    if ([[dict objectForKey:@"type"] isEqualToString:callCell]) {
        VVCallCell* cell = [[VVCallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:callCell];
        
        cell.titleLabel.text = [dict objectForKey:@"title"];
        cell.detailLabel.text = [dict objectForKey:@"value"];
        
        defaultCell = cell;
    }
    
    if ([[dict objectForKey:@"type"] isEqualToString:detailWithSegueCell]) {
        VVDetailWithSegueCell* cell = [[VVDetailWithSegueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailWithSegueCell];
        
        cell.titleLabel.text = [dict objectForKey:@"title"];
        cell.detailLabel.text = [dict objectForKey:@"value"];
        
        defaultCell = cell;
    }
    
    if ([[dict objectForKey:@"type"] isEqualToString:detailStaticTitleWithDescriptionCell]) {
        VVDetailStaticTitleWithDescriptionCell* cell = [[VVDetailStaticTitleWithDescriptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailStaticTitleWithDescriptionCell];
        cell.titleLabel.text = [dict objectForKey:@"title"];
        cell.detailLabel.text = [dict objectForKey:@"value"];
        
        defaultCell = cell;
    }
    
    return defaultCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"didSelectRowAtIndexPath: %@", indexPath);
    NSDictionary* dict = [self.tableData objectAtIndex:indexPath.row];
    
    if ([[dict objectForKey:@"type"] isEqualToString:detailWithSegueCell]) {
        [self showPhotosForAdvertising];
    }
    
    if ([[dict objectForKey:@"type"] isEqualToString:callCell]) {
        [self showAlertForCallPhoneNumber];
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

#pragma mark - callPhone

- (void)showAlertForCallPhoneNumber
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:[self.model getRieltor]
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
        [self callPhone:[NSString stringWithFormat:@"+7%@", [self.model phone]]];
    } else {
        // otherwise
        NSLog(@"NO");
    }
}

#pragma mark - MWPhotoBrowserDelegate

- (void)loadPhotoFromServer
{
    NSMutableArray* photos = [NSMutableArray array];
    for (NSString* urlString in self.model.photos) {
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:urlString]]];
    }
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
