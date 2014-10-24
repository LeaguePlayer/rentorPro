//
//  VVBaseViewController.m
//  rentor
//
//  Created by vegera on 25.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVBaseViewController.h"

@interface VVBaseViewController ()

@end

@implementation VVBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // change font color for navigation bar
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"PT Sans" size:10], NSFontAttributeName,
                                                                     nil]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; // цвет текста назад
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0];
}

+ (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)uuidStringRef;
}

#pragma mark - Alert

- (void)showAlert:(NSString *)message
{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Ошибка!"
                          message:message
                          delegate:self  // set nil if you don't want the yes button callback
                          cancelButtonTitle:@"Да"
                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
