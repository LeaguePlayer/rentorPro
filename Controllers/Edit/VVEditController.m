//
//  VVEditController.m
//  Rentor
//
//  Created by vegera on 23.10.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVEditController.h"
#import "VVRealty.h"

#import "VVSimpleTopCell.h"
#import "VVTitleWithSegueCell.h"
#import "VVTitleWithCheckboxCell.h"
#import "VVTwoTextViewWithTitleCell.h"
#import "VVTitleWithTextFieldAndSliderCell.h"
#import "VVOptionsTableViewController.h"

@interface VVEditController ()

@property (strong, nonatomic) VVRealty* model;

@property (assign, nonatomic) BOOL type;

@property (strong, nonatomic) NSDictionary* responseDictionary;

@property (strong, nonatomic) NSArray* cellArray;

@end

static NSString* textLabel = @"textLabel";
static NSString* simpleTopCell = @"simpleTopCell";
static NSString* titleWithSegueCell = @"titleWithSegueCell";
static NSString* titleWithCheckboxCell = @"titleWithCheckboxCell";
static NSString* twoTextViewWithTitleCell = @"twoTextViewWithTitleCell";
static NSString* titleWithTextFieldAndSliderCell = @"titleWithTextFieldAndSliderCell";

@implementation VVEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self addLeftMenuButton];
    
    UIBarButtonItem* rightSegue = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconNext.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextSegue)];
    self.navigationItem.rightBarButtonItem = rightSegue;
    
//    self.model = [[VVRealty alloc] init];
    
    [self initCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nextSegue
{
    //
}

- (void)initCell
{
    NSArray* estate = @[
                        
                        @{@"title": @"Серия дома",
                          @"placeholder" : self.model.suiteLabelText.length != 0 ? self.model.suiteLabelText : @"выбрать",
                          @"select" : @"suites",
                          @"keyLabel": @"responseDictionary",
                          @"modelField": @"suite",
                          @"captionTitle": @"Серия дома",
                          @"type": titleWithSegueCell},
                        
                        @{@"title": @"Мебель",
                          @"placeholder" : self.model.furnitureLabelText.length != 0 ? self.model.furnitureLabelText : @"выбрать",
                          @"select" : @"furnitures",
                          @"keyLabel": @"responseDictionary",
                          @"modelField": @"furniture",
                          @"captionTitle": @"Доступно",
                          @"type": titleWithSegueCell},
                        
                        @{@"title": @"Что",
                          @"placeholder" : self.model.whatLabelText.length != 0 ? self.model.whatLabelText : @"выбрать",
                          @"select" : @"whats",
                          @"keyLabel": @"responseDictionary",
                          @"modelField": @"what",
                          @"captionTitle": @"Что",
                          @"type": titleWithSegueCell},
                        
                        @{@"title": @"Максимальная цен*, руб",
                          @"type": titleWithTextFieldAndSliderCell},
                        
                        @{@"title": @"Срок",
                          @"placeholder" : self.model.periodLabelText.length != 0 ? self.model.periodLabelText : @"выбрать",
                          @"select" : @"periods",
                          @"keyLabel": @"responseDictionary",
                          @"modelField": @"period",
                          @"captionTitle": @"Срок",
                          @"type": titleWithSegueCell},
                        
                        @{@"title": @"С мал. детьми",
                          @"model" : @"malchild",
                          @"type": titleWithCheckboxCell},
                        
                        @{@"title": @"С животными",
                          @"model" : @"withanimal",
                          @"type": titleWithCheckboxCell},
                        
                        @{@"title": @"Не русские",
                          @"model" : @"notrussia",
                          @"type": titleWithCheckboxCell},
                        
                        @{@"title": @"Район",
                          @"placeholder" : self.model.regionLabelText,
                          @"select" : @"regions",
                          @"keyLabel": @"responseDictionary",
                          @"modelField": @"region",
                          @"captionTitle": @"Район",
                          @"type": titleWithSegueCell},
                        
                        @{@"titlePublic":@"Публичная информация",
                          @"titlePrivate":@"Конфиденциальная информация",
                          @"type": twoTextViewWithTitleCell}
                        ];
    
    NSArray* client = @[
                        
                        @{@"title": @"Серия дома",
                          @"placeholder" : @"выбрать",
                          @"select" : @"suites",
                          @"keyLabel": @"responseDictionary",
                          @"modelField": @"suite",
                          @"captionTitle": @"Серия дома",
                          @"type": titleWithSegueCell},
                        
                        @{@"title": @"Мебель",
                          @"placeholder" : @"выбрать",
                          @"select" : @"furnitures",
                          @"keyLabel": @"responseDictionary",
                          @"modelField": @"furniture",
                          @"captionTitle": @"Доступно",
                          @"type": titleWithSegueCell},
                        
                        @{@"title": @"Кто",
                          @"placeholder" : @"выбрать",
                          @"select" : @"whos",
                          @"keyLabel": @"responseDictionary",
                          @"modelField": @"whos",
                          @"captionTitle": @"Кто",
                          @"type": titleWithSegueCell},
                        
                        @{@"title": @"Максимальная цен*, руб",
                          @"type": titleWithTextFieldAndSliderCell},
                        
                        @{@"title": @"Срок",
                          @"placeholder" : @"не указано",
                          @"select" : @"periods",
                          @"keyLabel": @"responseDictionary",
                          @"modelField": @"period",
                          @"captionTitle": @"Срок",
                          @"type": titleWithSegueCell},
                        
                        @{@"title": @"С мал. детьми",
                          @"model" : @"malchild",
                          @"type": titleWithCheckboxCell},
                        
                        @{@"title": @"С животными",
                          @"model" : @"withanimal",
                          @"type": titleWithCheckboxCell},
                        
                        @{@"title": @"Не русские",
                          @"model" : @"notrussia",
                          @"type": titleWithCheckboxCell},
                        
                        @{@"title": @"Район",
                          @"placeholder" : @"выбрать",
                          @"select" : @"regions",
                          @"keyLabel": @"responseDictionary",
                          @"modelField": @"region",
                          @"captionTitle": @"Район",
                          @"type": titleWithSegueCell},
                        
                        @{@"titlePublic":@"Публичная информация",
                          @"titlePrivate":@"Конфиденциальная информация",
                          @"type": twoTextViewWithTitleCell}
                        ];
    
    if ([self.model.type isEqualToString:@"estate"]) {
        self.cellArray = estate;
//        self.model.type = @"estate";
    } else {
        self.cellArray = client;
//        self.model.type = @"client";
    }
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"text: %lu", (unsigned long)textView.text.length);
    int limit = 254;
    if (!([textView.text length]>limit && [text length] > range.length)) {
        if ([textView tag] == 1) {
            self.model.comment_private = textView.text;
        } else {
            self.model.comment_public = textView.text;
        }
    }
    return !([textView.text length]>limit && [text length] > range.length);
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* dict = [self.cellArray objectAtIndex:indexPath.row];
    
    if ([[dict objectForKey:@"type"] isEqualToString:simpleTopCell]) {
        return 56.f;
    }
    
    if ([[dict objectForKey:@"type"] isEqualToString:titleWithSegueCell]) {
        return 45.f;
    }
    
    if ([[dict objectForKey:@"type"] isEqualToString:twoTextViewWithTitleCell]) {
        return 252.f;
    }
    
    if ([[dict objectForKey:@"type"] isEqualToString:titleWithTextFieldAndSliderCell]) {
        return 111.f;
    }
    
    return 45.f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cellDefault;
    
    NSDictionary* dict = [self.cellArray objectAtIndex:indexPath.row];
    
    if ([[dict objectForKey:@"type"] isEqualToString:simpleTopCell]) {
        VVSimpleTopCell* cell = [tableView dequeueReusableCellWithIdentifier:simpleTopCell];
        
        if (!cell) {
            cell = [[VVSimpleTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTopCell];
        }
        
        [cell.iconImageView setImage:cell.stepOneImage];
        cell.titleLabel.text = [dict objectForKey:@"title"];
        
        cellDefault = cell;
    }
    
    if ([[dict objectForKey:@"type"] isEqualToString:titleWithSegueCell]) {
        VVTitleWithSegueCell* cell = [tableView dequeueReusableCellWithIdentifier:titleWithSegueCell];
        
        if (!cell) {
            cell = [[VVTitleWithSegueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleWithSegueCell];
        }
        
        cell.titleLabel.text = [dict objectForKey:@"title"];
        if ([[self.model valueForKey:[NSString stringWithFormat:@"%@LabelText", [dict objectForKey:@"modelField"]]] length] > 0) {
            cell.detailLabel.text = [self.model valueForKey:[NSString stringWithFormat:@"%@LabelText", [dict objectForKey:@"modelField"]]];
        } else {
            cell.detailLabel.text = [dict objectForKey:@"placeholder"];
        }
        
        cellDefault = cell;
    }
    
    if ([[dict objectForKey:@"type"] isEqualToString:titleWithCheckboxCell]) {
        VVTitleWithCheckboxCell* cell = [tableView dequeueReusableCellWithIdentifier:titleWithCheckboxCell];
        
        if (!cell) {
            cell = [[VVTitleWithCheckboxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleWithCheckboxCell];
        }
        
        cell.titleLabel.text = [dict objectForKey:@"title"];
        
        if ([self.model valueForKey:[dict objectForKey:@"model"]]) {
            [cell.iconImageView setImage:cell.disabledImage];
        } else {
            [cell.iconImageView setImage:cell.enabledImage];
        }
        
        cellDefault = cell;
    }
    
    if ([[dict objectForKey:@"type"] isEqualToString:twoTextViewWithTitleCell]) {
        VVTwoTextViewWithTitleCell* cell = [tableView dequeueReusableCellWithIdentifier:twoTextViewWithTitleCell];
        
        if (!cell) {
            cell = [[VVTwoTextViewWithTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:twoTextViewWithTitleCell];
        }
        
        cell.privateTitleLabel.text = [dict objectForKey:@"titlePrivate"];
        cell.publicTitleLabel.text = [dict objectForKey:@"titlePublic"];
        
        cell.privateCommentTextView.delegate = self;
        cell.publicCommentTextView.delegate = self;
        
        cellDefault = cell;
    }
    
    if ([[dict objectForKey:@"type"] isEqualToString:titleWithTextFieldAndSliderCell]) {
        VVTitleWithTextFieldAndSliderCell* cell = [tableView dequeueReusableCellWithIdentifier:titleWithTextFieldAndSliderCell];
        
        if (!cell) {
            cell = [[VVTitleWithTextFieldAndSliderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleWithTextFieldAndSliderCell];
        }
        
        cell.titleLabel.text = [dict objectForKey:@"title"];
        cell.model = self.model;
        
        cellDefault = cell;
    }
    
    return cellDefault;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"didSelectRowAtIndexPath: %d", indexPath.row);
    
    [self.tableView endEditing:YES];
    
    NSDictionary* dict = [self.cellArray objectAtIndex:indexPath.row];
    
    if ([[dict objectForKey:@"type"] isEqualToString:titleWithCheckboxCell]) {
        VVTitleWithCheckboxCell* cell = (VVTitleWithCheckboxCell *) [tableView cellForRowAtIndexPath:indexPath];
        
        if ([[self.model valueForKey:[dict objectForKey:@"model"]] boolValue]) {
            [cell.iconImageView setImage:cell.disabledImage];
            [self.model setValue:@NO forKey:[dict objectForKey:@"model"]];
        } else {
            [cell.iconImageView setImage:cell.enabledImage];
            [self.model setValue:@YES forKey:[dict objectForKey:@"model"]];
        }
    }
    
    if ([[dict objectForKey:@"type"] isEqualToString:titleWithSegueCell]) {
        NSDictionary* d = @{@"select": [dict objectForKey:@"select"],
                            @"keyLabel": [dict objectForKey:@"keyLabel"],
                            @"captionTitle": [dict objectForKey:@"captionTitle"],
                            @"modelField": [dict objectForKey:@"modelField"],
                            @"indexPath": indexPath};
        
        [self performSegueWithIdentifier:@"optionsSegue" sender:d];
    }
}

#pragma mark - Setters

- (void)setResponseDictionary:(NSDictionary *)responseDictionary
{
    [self.model setValue:[responseDictionary objectForKey:@"id"] forKey:[responseDictionary objectForKey:@"modelField"]];
    [self.model setValue:[responseDictionary objectForKey:textLabel] forKey:[NSString stringWithFormat:@"%@LabelText", [responseDictionary objectForKey:@"modelField"]]];
    VVTitleWithSegueCell* cell = (VVTitleWithSegueCell *) [self.tableView cellForRowAtIndexPath:[responseDictionary objectForKey:@"indexPath"]];
    cell.detailLabel.text = [responseDictionary objectForKey:textLabel];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@", sender);
    
    if ([[segue identifier] isEqualToString:@"optionsSegue"]) {
        
        // Get destination view
        VVOptionsTableViewController *vc = [segue destinationViewController];
        
        // Pass the information to your destination view
        [vc setValue:[sender objectForKey:@"select"] forKey:@"select"];
        [vc setValue:[sender objectForKey:@"keyLabel"] forKey:@"keyLabel"];
        [vc setValue:[sender objectForKey:@"captionTitle"] forKey:@"captionTitle"];
        [vc setValue:[sender objectForKey:@"modelField"] forKey:@"modelField"];
        [vc setValue:[sender objectForKey:@"indexPath"] forKey:@"indexPath"];
    }
}

@end
