//
//  DDAUIActionSheetViewController.h
//  UIActionSheetExample
//
//  Created by Dulio Denis on 3/23/14.
//  Copyright (c) 2014 ddApps. All rights reserved.
//

@interface DDAUIActionSheetViewController : UIViewController

@property (strong, nonatomic) id delegate;

- (void)slideOut;
- (IBAction)actionDelete:(UIButton *)sender;
- (IBAction)actionUnset:(UIButton *)sender;
- (IBAction)actionProlong:(UIButton *)sender;

@end
