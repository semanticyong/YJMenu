//
//  YJMenu.m
//  NSMutableAttributedString
//
//  Created by yong on 10/25/14.
//  Copyright (c) 2014 yong. All rights reserved.
//

#import "YJMenu.h"

@implementation YJMenu

- (YJMenu *)initWithMenuFrame:(CGRect)menuframe
                    MenuStyle:(YJMenuStyle)menuStyle
                   ItemTitles:(NSArray *)itemtitles
           ItemSelectedIndexs:(NSArray *)itemSelectedIndexs
        MenuItemSeparatorView:(UIView *)menuItemSeparatorView
                      BgColor:(UIColor *)bgColor
              SelectedBgColor:(UIColor *)selectedBgColor
             NotificationName:(NSString *)notificationName

{
    if ([itemtitles count] != [itemSelectedIndexs count]) {
        return nil;
    }
    
    self = [self initWithFrame:menuframe];
    
    if (self) {
        if ([itemtitles count]) {
            NSInteger titlesCount = [itemtitles count];
            switch (menuStyle) {
                case YJMenuStyleVertical: {
                    CGFloat menuHeight = 0.0f;
                    CGFloat menuWidth = 0.0f;
                    CGFloat menuItemSeparatorHeight = menuItemSeparatorView.frame.size.height;
                        menuHeight = (menuframe.size.height - (titlesCount - 1) * menuItemSeparatorHeight) / titlesCount;
                        menuWidth = menuframe.size.width;
                    CGRect menuItemRect = CGRectZero;
                    menuItemRect.size = CGSizeMake(menuWidth, menuHeight);
                    YJMenuItem *menuItem = [[YJMenuItem alloc] initWithItemTitle:itemtitles[0]
                                                                           Frame:menuItemRect
                                                                         BgColor:bgColor
                                                                 SelectedBgColor:selectedBgColor
                                                               ItemSelectedIndex:itemSelectedIndexs[0]
                                                                NotificationName:notificationName];
                    [self addSubview:menuItem];
                    
                    //do we have at least 2 items?
                    if (titlesCount > 1) {
                        //yes, we have at least 2 items, lets begin with 2nd menu item
                        NSInteger itemIndex = 1;
                        for (itemIndex = 1; itemIndex < titlesCount; itemIndex ++) {
                            //there may be a separator between 1st item and 2nd item, (2nd and 3rd, and so on)
                            //lets check it out
                            
                            if (menuItemSeparatorView) {
                                //mI stands for menu Item
                                UIView *mISeparatorView = [[UIView alloc] initWithFrame:menuItemSeparatorView.frame];
                                mISeparatorView.backgroundColor = menuItemSeparatorView.backgroundColor;
                                if (menuStyle == YJMenuStyleVertical) {
                                    CGFloat menuItemSeparatorOriginX = menuItemRect.origin.x;
                                    CGFloat menuItemSeparatorOriginY = menuItemRect.origin.y + menuItemRect.size.height;
                                    CGFloat menuItemSeparatorSizeWidth = mISeparatorView.frame.size.width;
                                    CGFloat menuItemSeparatorSizeHeight = mISeparatorView.frame.size.height;
                                    mISeparatorView.frame = CGRectMake(menuItemSeparatorOriginX, menuItemSeparatorOriginY, menuItemSeparatorSizeWidth, menuItemSeparatorSizeHeight);
                                }
                                [self addSubview:mISeparatorView];
                            }
                            
                            menuItemRect = [self setNextItemWithFrame:menuItemRect
                                                            MenuStyle:menuStyle
                                                            ItemTitle:itemtitles[itemIndex]
                                                    ItemSelectedIndex:itemSelectedIndexs[itemIndex]
                                                MenuItemSeparatorView:menuItemSeparatorView
                                                              BgColor:bgColor
                                                      SelectedBgColor:selectedBgColor
                                                     NotificationName:notificationName];
                        }

                    }
                }
                    
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    return self;
}

- (YJMenu *)initWithMenuFrame:(CGRect)menuframe
                    MenuStyle:(YJMenuStyle)menuStyle
                   ItemTitles:(NSArray *)itemtitles
           ItemSelectedIndexs:(NSArray *)itemSelectedIndexs
     MenuItemSeparatorPadding:(CGFloat)menuItemSeparatorPadding
                      BgColor:(UIColor *)bgColor
              SelectedBgColor:(UIColor *)selectedBgColor
                 PaddingColor:(UIColor *)paddingColor
             NotificationName:(NSString *)notificationName
{
    CGRect menuItemRect = CGRectZero;
    menuItemRect = [self setNextItemWithFrame:menuItemRect
                                    MenuStyle:menuStyle
                                    ItemTitle:[itemtitles objectAtIndex:1]
                            ItemSelectedIndex:itemSelectedIndexs[1]
                     MenuItemSeparatorPadding:menuItemSeparatorPadding
                                      BgColor:bgColor
                              SelectedBgColor:selectedBgColor
                             NotificationName:notificationName];
    
    UIView *menuItemSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 2)];
    
    if (menuStyle == YJMenuStyleVertical) {
        CGFloat menuItemSeparatorSizeWidth = menuItemRect.size.width - 6;
        CGFloat menuItemSeparatorSizeHeight = 1.0f;
        CGFloat menuItemSeparatorOriginX = menuItemRect.origin.x + 3;
        CGFloat menuItemSeparatorOriginY = menuItemRect.origin.y + menuItemRect.size.height + menuItemSeparatorPadding / 2;
        menuItemSeparator.frame = CGRectMake(menuItemSeparatorOriginX, menuItemSeparatorOriginY, menuItemSeparatorSizeWidth, menuItemSeparatorSizeHeight);
    }
    menuItemSeparator.backgroundColor = paddingColor;

    return self;
}

- (CGRect)setNextItemWithFrame:(CGRect)frame
                     MenuStyle:(YJMenuStyle)menuStyle
                     ItemTitle:(NSString *)itemTitle
             ItemSelectedIndex:(NSNumber *)itemSelectedIndex
      MenuItemSeparatorPadding:(CGFloat)menuItemSeparatorPadding
                       BgColor:(UIColor *)bgColor
               SelectedBgColor:(UIColor *)selectedBgColor
              NotificationName:(NSString *)name
{
    if (menuStyle == YJMenuStyleVertical) {
        frame.origin.y = [self getOriginYForNextItemWithFrame:frame Padding:menuItemSeparatorPadding];
    }
    else {
        frame.origin.x = [self getOriginXForNextItemWithFrame:frame Padding:menuItemSeparatorPadding];
    }
    
    YJMenuItem *menuItem = [[YJMenuItem alloc] initWithItemTitle:itemTitle
                                                           Frame:frame
                                                         BgColor:bgColor
                                                 SelectedBgColor:selectedBgColor
                                               ItemSelectedIndex:itemSelectedIndex
                                                NotificationName:name];
    [self addSubview:menuItem];
    return frame;
}

- (CGRect)setNextItemWithFrame:(CGRect)frame
                     MenuStyle:(YJMenuStyle)menuStyle
                     ItemTitle:(NSString *)itemTitle
             ItemSelectedIndex:(NSNumber *)itemSelectedIndex
         MenuItemSeparatorView:(UIView *)menuItemSeparatorView
                       BgColor:(UIColor *)bgColor
               SelectedBgColor:(UIColor *)selectedBgColor
              NotificationName:(NSString *)name
{
    if (menuStyle == YJMenuStyleVertical) {
        frame.origin.y = [self getOriginYForNextItemWithFrame:frame Padding:menuItemSeparatorView.frame.size.height];
    }
    else {
        frame.origin.x = [self getOriginXForNextItemWithFrame:frame Padding:menuItemSeparatorView.frame.size.width];
    }
    
    YJMenuItem *menuItem = [[YJMenuItem alloc] initWithItemTitle:itemTitle
                                                           Frame:frame
                                                         BgColor:bgColor
                                                 SelectedBgColor:selectedBgColor
                                               ItemSelectedIndex:itemSelectedIndex
                                                NotificationName:name];
    [self addSubview:menuItem];
    return frame;
}

- (CGFloat)getOriginXForNextItemWithFrame:(CGRect)frame Padding:(CGFloat)padding
{
    CGFloat result = frame.origin.x + frame.size.width + padding;
    return result;
}

- (CGFloat)getOriginYForNextItemWithFrame:(CGRect)frame Padding:(CGFloat)padding
{
    CGFloat result = frame.origin.y + frame.size.height + padding;
    return result;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
