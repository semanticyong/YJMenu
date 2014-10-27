//
//  YJMenu.h
//  NSMutableAttributedString
//
//  Created by yong on 10/25/14.
//  Copyright (c) 2014 yong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJMenuItem.h"

typedef NS_ENUM(NSUInteger, YJMenuStyle) {
    YJMenuStyleVertical = 57,  //垂直的
    YJMenuStyleHorizontal
};

@interface YJMenu : UIView

/**
 * new an Menu that contains an array of Menu Items
 * all the items have the same size
 * @param   titles
 *          an array contains all the Items that consist of the menu
 * @param   padding
 *          space between 2 menu items
 *
 */
- (YJMenu *)initWithMenuFrame:(CGRect)menuframe
                    MenuStyle:(YJMenuStyle)menuStyle
                   ItemTitles:(NSArray *)itemtitles
           ItemSelectedIndexs:(NSArray *)itemSelectedIndexs
        MenuItemSeparatorView:(UIView *)menuItemSeparatorView
                      BgColor:(UIColor *)bgColor
              SelectedBgColor:(UIColor *)selectedBgColor
             NotificationName:(NSString *)notificationName;

- (YJMenu *)initWithMenuFrame:(CGRect)menuframe
                    MenuStyle:(YJMenuStyle)menuStyle
                   ItemTitles:(NSArray *)itemtitles
           ItemSelectedIndexs:(NSArray *)itemSelectedIndexs
     MenuItemSeparatorPadding:(CGFloat)menuItemSeparatorPadding
                      BgColor:(UIColor *)bgColor
              SelectedBgColor:(UIColor *)selectedBgColor
                 PaddingColor:(UIColor *)paddingColor
             NotificationName:(NSString *)notificationName;

@end
