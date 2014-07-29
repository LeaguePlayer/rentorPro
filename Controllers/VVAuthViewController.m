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
    
//    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"VVFilterTableViewController"]
//                       animated:NO
//                     completion:^{
//                         //
//                     }];
    [self textFieldInit];
    //VVFilterTableViewController* viewController = [[VVFilterTableViewController alloc] init];
    //[self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"VVFilterTableViewController"] animated:NO];
    
    NSLog(@" step one %i",[self.navigationController.viewControllers count]);
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    // self.navigationController.viewControllers;
}

- (void)textFieldInit
{
    self.loginTextField.frame = CGRectMake(22, 266, 278, 44);
    self.passwordTextField.frame = CGRectMake(22, 327, 278, 44);
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

#pragma mark - Actions

- (IBAction)actionInputPhoneNumber:(UITextField *)sender
{
    NSLog(@"%@", sender.text);
}

- (IBAction)actionInputPassword:(UITextField *)sender
{
    NSLog(@"%@", sender.text);
}

@end
