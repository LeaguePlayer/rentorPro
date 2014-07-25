//
//  VVAuthViewController.m
//  rentor
//
//  Created by A-Mobile LLC on 24.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVAuthViewController.h"

@interface VVAuthViewController ()

@end

@implementation VVAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // скругляем углы для кнопки
    [self roundMyView:self.loginButton borderRadius:5.0f borderWidth:2.0f color:nil];
    
    //UINavigationController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VVSettingsTableViewController"];
    //self.navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"VVSettingsTableViewController"];
    //[self.navigationController resetTopViewAnimated:YES];
    /*[self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"VVSettingsTableViewController"]
                       animated:NO
                     completion:^{
                         //
                     }];*/
    
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"VVAdvertisingsAndClientsViewController"]
                       animated:NO
                     completion:^{
                         //
                     }];
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

#pragma mark - MethodForView

- (void)roundMyView:(UIView*)view
       borderRadius:(CGFloat)radius
        borderWidth:(CGFloat)border
              color:(UIColor*)color
{
    CALayer *layer = [view layer];
    layer.masksToBounds = YES;
    layer.cornerRadius = radius;
    layer.borderWidth = border;
    layer.borderColor = color.CGColor;
}

@end
