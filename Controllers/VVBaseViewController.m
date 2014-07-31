//
//  VVBaseViewController.m
//  rentor
//
//  Created by vegera on 25.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVBaseViewController.h"
#import "UIViewController+ECSlidingViewController.h"

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

@end
