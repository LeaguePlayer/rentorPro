//
//  VVAuthViewController.m
//  rentor
//
//  Created by A-Mobile LLC on 24.07.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVAuthViewController.h"
#import "VVServerManager.h"
#import "MBProgressHUD.h"

@interface VVAuthViewController ()

@end

static NSString* kToken = @"token";

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
    
    
    // -------------------------------------------------------------- //
    //UIKeyboardDidHideNotification when keyboard is fully hidden
    //name:UIKeyboardWillHideNotification when keyboard is going to be hidden
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [self.view endEditing:YES];
}

- (void)textFieldInit
{
    self.loginTextField.frame = CGRectMake(22, 266, 278, 44);
    self.passwordTextField.frame = CGRectMake(22, 327, 278, 44);
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

- (IBAction)actionHideKeyboard:(UIButton *)sender {
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.upView.frame = CGRectMake(0, 0, self.upView.frame.size.width, self.upView.frame.size.height);
    }];
}

- (IBAction)actionLogin:(UIButton *)sender {
    [self authMethod];
}

#pragma mark - Actions

- (IBAction)actionInputPhoneNumber:(UITextField *)sender forEvent:(UIEvent *)event {
    NSLog(@"%@", sender.text);
}

- (IBAction)actionInputPassword:(UITextField *)sender forEvent:(UIEvent *)event {
    NSLog(@"%@", sender.text);
}

#pragma mark - Keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn: %@", textField);
    [self authMethod];
    return YES;
}

- (void)authMethod
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self authWithServer];
}

- (void)onKeyboardHide:(NSNotification *)notification
{
    //keyboard will hide
    NSLog(@"onKeyboardHide");
}

- (void)onKeyboardShow:(NSNotification *)notification
{
    //keyboard will show
    NSLog(@"onKeyboardShow");
    [UIView animateWithDuration:0.3 animations:^{
        self.upView.frame = CGRectMake(0, -20, self.upView.frame.size.width, self.upView.frame.size.height);
    }];
}

#pragma mark - API

- (void)authWithServer
{
    if (self.loginTextField.text.length <= 0 || self.passwordTextField.text.length <= 0) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showAlert:@"Не заполнено поле логина или пароля."];
        return;
    }
    [[VVServerManager sharedManager] authUserWithPhoneNumber:self.loginTextField.text
                                                    password:self.passwordTextField.text
                                                   onSuccess:^(NSString *token) {
                                                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                       [self performSegueWithIdentifier:@"successLoginSegue" sender:nil];
                                                       [self resetTextField];
                                                       [self saveToken:token];
                                                       [self.view endEditing:YES];
                                                   }
                                                   onFailure:^(NSError *error, NSInteger statusCode) {
                                                       NSLog(@"error: %@, statusCode:%d", error, statusCode);
                                                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                       if (statusCode == 666) {
                                                           [self showAlert:@"Отсутствует соединение с интернетом."];
                                                       } else {
                                                           [self showAlert:@"Не верно введен логин или пароль. Проверьте правильность введенных данных."];
                                                       }
                                                   }];
}

- (void)resetTextField
{
    self.loginTextField.text = @"";
    self.passwordTextField.text = @"";
}

- (void)saveToken:(NSString *)token {
    NSUserDefaults* userSettings = [NSUserDefaults standardUserDefaults];
    [userSettings setObject:token forKey:kToken];
    [userSettings synchronize];
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
