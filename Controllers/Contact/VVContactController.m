//
//  VVContactController.m
//  Rentor
//
//  Created by vegera on 24.10.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVContactController.h"

#import <AddressBook/AddressBook.h>
#import "VVAddressBookModel.h"
#import "VVAddressBookCell.h"

@interface VVContactController ()

@property (strong, nonatomic) NSArray* addressArray;

@end

static NSString* identifier = @"addressBookCell";

@implementation VVContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self addRightMenuButton];
    
    if ([self accessGranted]) {
        [self showContacts];
    }
    
    self.title = @"Контакты";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AddressBook

- (BOOL)accessGranted {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) {
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    } else {
        accessGranted = YES;
    }
    
    CFRelease(addressBook);
    
    return accessGranted;
}

- (void)showContacts {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    if (addressBook) {
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        if (allPeople) {
            NSMutableArray* modelArray = [NSMutableArray array];
            for (int index=0; index<CFArrayGetCount(allPeople); index++){
                ABRecordRef thisPerson = CFArrayGetValueAtIndex(allPeople, index);
                
                NSString *firstName = (__bridge NSString *)ABRecordCopyValue(thisPerson,
                                                                             kABPersonFirstNameProperty);
                NSString *lastName = (__bridge NSString *)ABRecordCopyValue(thisPerson,
                                                                            kABPersonLastNameProperty);
                
                ABMultiValueRef phoneMultiValue = ABRecordCopyValue(thisPerson, kABPersonPhoneProperty);
                NSArray *phoneNumber = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(phoneMultiValue);
                
                NSLog(@"First Name = %@", firstName);
                NSLog(@"Last Name = %@", lastName);
                NSLog(@"phoneNumber = %@", [phoneNumber firstObject]);
                
                VVAddressBookModel* model = [[VVAddressBookModel alloc] init];
                [model setName:[NSString stringWithFormat:@"%@ %@", (firstName? firstName : @""), (lastName? lastName : @"")]];
                [model setPhoneNumber:[phoneNumber firstObject]];
                
                if ([phoneNumber firstObject] && (firstName || lastName)) {
                    [modelArray addObject:model];
                }
                
                CFRelease(phoneMultiValue);
            }
            self.addressArray = modelArray;
            
            CFRelease(allPeople);
        }
        CFRelease(addressBook);
    }
}

#pragma mark - URLSchema

- (void)sendSmsWithPhoneNumbers:(NSArray *)numbers
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = @"Hello from Mugunth";
        controller.recipients = numbers;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
        case MessageComposeResultFailed:
            ////			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MyApp" message:@"Unknown Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            //			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MyApp" message:@"Unknown Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //			[alert show];
            //			[alert release];
            NSLog(@"Unknown Error");
            break;
        case MessageComposeResultSent:
            
            break;
        default:
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - BarButtonMenu

//- (void)addRightMenuButton
//{
//    UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:[[VVThemeManager sharedManager] getImageNameForRightMenuButtonInContactController]]
//                                                               style:UIBarButtonItemStylePlain
//                                                              target:self
//                                                              action:@selector(actionSendMessage)];
//    
//    [self.navigationItem setRightBarButtonItem:button];
//}

- (void)actionSendMessage
{
    NSLog(@"actionSendMessage");
    NSMutableArray* numbers = [NSMutableArray array];
    for (VVAddressBookModel* model in self.addressArray) {
        if (model.selected) {
            [numbers addObject:model.phoneNumber];
        }
    }
    
    [self sendSmsWithPhoneNumbers:numbers];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.addressArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VVAddressBookModel* model = [self.addressArray objectAtIndex:indexPath.row];
    
    VVAddressBookCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[VVAddressBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.titleLabel.text = model.name;
    cell.detailLabel.text = model.phoneNumber;
    if (model.selected) {
        [cell.iconImageView setImage:cell.enabledImage];
    } else {
        [cell.iconImageView setImage:cell.disabledImage];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VVAddressBookModel* model = [self.addressArray objectAtIndex:indexPath.row];
    VVAddressBookCell* cell = (VVAddressBookCell *) [tableView cellForRowAtIndexPath:indexPath];
    
    if (model.selected) {
        model.selected = NO;
        [cell.iconImageView setImage:cell.disabledImage];
    } else {
        model.selected = YES;
        [cell.iconImageView setImage:cell.enabledImage];
    }
}

@end
