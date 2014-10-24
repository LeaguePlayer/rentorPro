//
//  VVSelectPhotoCollectionController.m
//  rentor
//
//  Created by vegera on 09.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVSelectPhotoCollectionController.h"
#import "VVServerManager.h"
#import "MBProgressHUD.h"

#import "VVPhotoCollectionCell.h"

#import "VVRealty.h"

@interface VVSelectPhotoCollectionController ()

@property (strong, nonatomic) VVRealty* model;

@end

static NSString* photoCollectionCell = @"photoCollectionCell";

@implementation VVSelectPhotoCollectionController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // set up toolbar
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [toolbar setBackgroundColor:[UIColor blackColor]];
    [toolbar setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 130.0f; // or whatever you want
    
    UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"photo_button.png"] style:UIBarButtonItemStylePlain target:self action:@selector(takePhoto)];
    [self.view addSubview:toolbar];
    
    // instantiate spacer, middleItem
    toolbar.items = @[fixedItem, button];
//    toolbar.items = @[spacer, middleItem, spacer];
}

- (void)takePhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePicker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *pickedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (pickedImage) {
        [self.model.photos addObject:pickedImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self.collectionView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem* rightSegue = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconNext.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextSegue)];
    self.navigationItem.rightBarButtonItem = rightSegue;
    
//    self.images = [NSMutableArray array];
    
    [self.collectionView registerClass:[VVPhotoCollectionCell class] forCellWithReuseIdentifier:photoCollectionCell];
}

- (void)nextSegue
{
    NSLog(@"nextSegue");
    [self postServer];
    NSLog(@"model: %@", [self.model description]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void)postServer
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[VVServerManager sharedManager] postAdvFromModel:self.model
                                            onSuccess:^(id result) {
                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                NSLog(@"onSuccess: %@", result);
                                                [self performSegueWithIdentifier:@"postEndSegue" sender:nil];
                                            }
                                            onFailure:^(NSError *error, NSInteger statusCode) {
                                                NSLog(@"error: %@, statusCode:%d", error, statusCode);
                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                if (statusCode == 666) {
                                                    [self showAlert:@"Отсутствует соединение с интернетом."];
                                                } else {
                                                    [self showAlert:@"Ошибка в передаче данных."];
                                                }
                                                [self performSegueWithIdentifier:@"postEndSegue" sender:nil];
                                            }];
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

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectItemAtIndexPath: %@", indexPath);
    [self.model.photos removeObjectAtIndex:indexPath.row];
    
    [collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.model.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VVPhotoCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCollectionCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[VVPhotoCollectionCell alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];
    }
    
    [cell.photoImageView setImage:[self.model.photos objectAtIndex:indexPath.row]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"stepHeader" forIndexPath:indexPath];
        
        reusableview = headerView;
    }
    
    return reusableview;
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
