//
//  VVLoader.m
//  Rentor
//
//  Created by vegera on 21.10.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VVLoader.h"

@implementation VVLoader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(frame.size.width/2 - 30, frame.size.height/2 - 30, 60, 60)];
        UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator setFrame:CGRectMake(frame.size.width/2 - 30, frame.size.height/2 - 30, 60, 60)];
        [indicator setColor:[UIColor grayColor]];
        [indicator startAnimating];
        [self addSubview:indicator];
        [self setAlpha:0.f];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
