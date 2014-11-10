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
                 NotificationName:(NSString *)notificationName
{
    self = [self initWithItemTitle:title
                              Icon:nil
                             Frame:frame
                           BgColor:bgColor
                   SelectedBgColor:selectedBgColor
                 ItemSelectedIndex:itemSelectedIndex
                  NotificationName:notificationName];
    return self;
}

- (YJMenuItem *)initWithItemTitle:(NSString *)title
                             Icon:(UIImage *)icon
                            Frame:(CGRect)frame
                          BgColor:(UIColor *)bgColor
                  SelectedBgColor:(UIColor *)selectedBgColor
                ItemSelectedIndex:(NSNumber *)itemSelectedIndex
                 NotificationName:(NSString *)notificationName
{
    _selectedBgColor = selectedBgColor;
    
    self = [self initWithFrame:frame];
    
    CGRect itemFrame = frame;
    UILabel *titleLabel = [[UILabel alloc] init];
    CGRect labelRect = frame;
    
    if (icon) {
        UIImageView *iconImgView = [[UIImageView alloc] initWithImage:icon];
        CGRect imgViewRect = iconImgView.frame;
        CGSize imgViewSize = iconImgView.frame.size;
        
        NSDictionary *attrDict = @{NSFontAttributeName : [titleLabel font]};
        CGFloat titleWidth = [title sizeWithAttributes:attrDict].width;
        labelRect.size = CGSizeMake(titleWidth, frame.size.height);

        if ((imgViewSize.width + titleWidth) > itemFrame.size.width || imgViewSize.height > itemFrame.size.height) {
            // Does not have enough space to put Icon And Title
            // TODO: pass more error info
            return nil;
        }
        
        CGFloat paddingBetweenIconAndTitle = itemFrame.size.width/20;
        CGFloat paddingBetweenIconAndTop = (frame.size.height - imgViewSize.height) / 2;
        CGFloat paddingBetweenIconAndLeft = 0.0f;
        
        if ((imgViewSize.width + titleWidth + paddingBetweenIconAndTitle) > itemFrame.size.width) {
            // Does not have more space for default padding Between Icon And Title
            // We have to make an ugly padding
            paddingBetweenIconAndLeft = (itemFrame.size.width - (imgViewSize.width + titleWidth)) / 3;
            labelRect.origin.x = paddingBetweenIconAndLeft * 2 + imgViewSize.width;
        }
        else {
            paddingBetweenIconAndLeft = (itemFrame.size.width - (imgViewSize.width + titleWidth + paddingBetweenIconAndTitle)) / 2;
            labelRect.origin.x = paddingBetweenIconAndLeft + imgViewSize.width + paddingBetweenIconAndTitle;
        }
        
        imgViewRect.origin.x = paddingBetweenIconAndLeft;
        imgViewRect.origin.y = paddingBetweenIconAndTop;
        labelRect.origin.y = 0.0f;
        iconImgView.frame = imgViewRect;
        [self addSubview:iconImgView];
    }
    else {
        //does not have an icon, make the label be full of the menu item
        labelRect = frame;
        labelRect.origin = CGPointMake(0, 0);
    }
    
    titleLabel.frame = labelRect;
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];

    if (bgColor) {
        _bgColor = bgColor;
        self.backgroundColor = bgColor;
    }
    
    if (itemSelectedIndex) {
        self.tag = [itemSelectedIndex integerValue];
    }
    
    UITapGestureRecognizer *tapGR =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    [self addGestureRecognizer:tapGR];
    
    _itemSelectedNotificationName = nil;
    if (notificationName) {
        _itemSelectedNotificationName = notificationName;
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
