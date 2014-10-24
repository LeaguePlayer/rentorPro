//
//  VVSelectPhotoCollectionController.h
//  rentor
//
//  Created by vegera on 09.09.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VVSelectPhotoCollectionController : UICollectionViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *images;

@end
