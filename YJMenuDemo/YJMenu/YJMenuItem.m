//
//  YJMenuItem.m
//  XPLNCoreDataIPad
//
//  Created by yong on 10/23/14.
//  Copyright (c) 2014 yong. All rights reserved.
//

#import "YJMenuItem.h"

static NSString *ItemSelectedNotificationName = @"ItemSelectedNotification";

@interface YJMenuItem () {
    NSString *_itemSelectedNotificationName;
}

@end

@implementation YJMenuItem

- (YJMenuItem *)initWithItemTitle:(NSString *)title
                            Frame:(CGRect)frame
                          BgColor:(UIColor *)bgColor
                  SelectedBgColor:(UIColor *)selectedBgColor
                ItemSelectedIndex:(NSNumber *)itemSelectedIndex
                 NotificationName:(NSString *)name
{
    
    _selectedBgColor = selectedBgColor;
    self = [self initWithFrame:frame];
    CGRect lblFrame = frame;
    lblFrame.origin = CGPointMake(0, 0);
    UILabel *label = [[UILabel alloc] initWithFrame:lblFrame];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    
    if (bgColor) {
        _bgColor = bgColor;
        self.backgroundColor = bgColor;
    }
    
    if (itemSelectedIndex) {
        self.tag = [itemSelectedIndex integerValue];
    }
    
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    UITapGestureRecognizer *tapGR =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    [self addGestureRecognizer:tapGR];
    
    _itemSelectedNotificationName = nil;
    if (name) {
        _itemSelectedNotificationName = name;
    }
    else {
        _itemSelectedNotificationName = ItemSelectedNotificationName;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRecieved:) name:_itemSelectedNotificationName object:nil];
    
    [self setIsSelected:NO];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)handleTapGestureRecognizer:(id)sender
{
//    NSLog(@"handleTapGestureRecognizer");
//    NSLog(@"%@", sender);
    NSDictionary *userInfo = @{ItemSelectedIndexKey: @(self.tag)};
    [[NSNotificationCenter defaultCenter] postNotificationName:_itemSelectedNotificationName object:nil userInfo:userInfo];
    [self setIsSelected:YES];
}

- (void)notificationRecieved:(NSNotification *)notification
{
    NSDictionary * dict = notification.userInfo;
    NSNumber *index = dict[ItemSelectedIndexKey];
    if (self.tag != [index integerValue]) {
        [self setIsSelected:NO];
    }
}

- (void)setIsSelected:(BOOL)isSelected
{
    if (isSelected) {
        self.backgroundColor = _selectedBgColor;
    }
    else {
        self.backgroundColor = _bgColor;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
