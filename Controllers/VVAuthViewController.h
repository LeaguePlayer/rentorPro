//
//  VVAuthViewController.h
//  rentor
//
//  Created by A-Mobile LLC on 24.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface VVAuthViewController : UIViewController <UITextFieldDelegate>

#pragma mark - Properties
@property (weak, nonatomic) IBOutlet UIView *upView;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITextField* loginTextField;
@property (weak, nonatomic) IBOutlet UITextField* passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton* loginButton;

#pragma mark - Methods

- (IBAction)actionInputPhoneNumber:(UITextField *)sender forEvent:(UIEvent *)event;
- (IBAction)actionInputPassword:(UITextField *)sender forEvent:(UIEvent *)event;
- (void)roundMyView:(UIView*)view
       borderRadius:(CGFloat)radius
        borderWidth:(CGFloat)border
              color:(UIColor*)color;
- (IBAction)actionHideKeyboard:(UIButton *)sender;
- (IBAction)actionLogin:(UIButton *)sender;
- (IBAction)actionPrivacyPolicy:(UIButton *)sender;

@end
