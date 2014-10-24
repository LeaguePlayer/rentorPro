//
//  VVMenuController.m
//  rentor
//
//  Created by vegera on 10.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVMenuController.h"

@interface VVMenuController ()

@end

static CGFloat menuWidth = 259.f;
static CGFloat gestureWarkingAreaPercent = 15.f;
static NSString* kToken = @"token";

@implementation VVMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    NSString *identifier;
    switch (indexPath.row) {
        case 1:
            identifier = @"VVAdvertisingsAndClientsViewController";
            break;
        case 2:
            identifier = @"VVMainAdvViewController";
            break;
        case 3:
            identifier = @"VVNotificationViewController";
            break;
        case 5:
            identifier = @"VVCreateRealtyStepOneTableViewController";
            break;
        case 6:
            identifier = @"VVCreateClientTableViewController";
            break;
        case 7:
            identifier = @"VVSettingsTableViewController";
            break;
        case 8:
            identifier = @"favoritSegue";
            break;
            
        default:
            identifier = @"VVAdvertisingsAndClientsViewController";
            break;
    }
    
    return identifier;
}

- (void)configureSlideLayer:(CALayer *)layer
{
    [super configureSlideLayer:layer];
    layer.shadowOpacity = 0;
}

- (AMPrimaryMenu)primaryMenu
{
    return AMPrimaryMenuLeft;
}

- (CGFloat)leftMenuWidth
{
    return menuWidth;
}

- (CGFloat) panGestureWarkingAreaPercent
{
    return gestureWarkingAreaPercent;
}

- (void)actionLogout
{
    NSLog(@"actionLogout");
    [self resetToken];
    [self.navigationController popToRootViewControllerAnimated:YES]; // возвращаемся к рутовому контроллеру
}

- (void)resetToken
{
//    NSUserDefaults* userSettings = [NSUserDefaults standardUserDefaults];
//    [userSettings removeObjectForKey:kToken];
//    [userSettings synchronize];
    [[VVSettings sharedManager] removeToken];
}

//- (NSIndexPath *)initialIndexPathForLeftMenu
//{
//    return [NSIndexPath indexPathForRow:0 inSection:0];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
