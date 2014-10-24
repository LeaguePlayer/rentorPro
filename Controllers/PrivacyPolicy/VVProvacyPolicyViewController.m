//
//  VVProvacyPolicyViewController.m
//  Rentor
//
//  Created by vegera on 25.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVProvacyPolicyViewController.h"

@interface VVProvacyPolicyViewController ()

@end

@implementation VVProvacyPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionClose:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
