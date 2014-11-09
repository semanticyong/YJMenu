//
//  YJMenuItem.h
//  XPLNCoreDataIPad
//
//  Created by yong on 10/23/14.
//  Copyright (c) 2014 yong. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ItemSelectedIndexKey = @"ItemSelectedIndex";

@interface YJMenuItem : UIView

@property (readonly) BOOL isSelected;
@property (nonatomic, readonly) UIColor *selectedBgColor;
@property (nonatomic, readonly) UIColor *bgColor;

/**
 * new an Menu Item
 * @param   bgColor
 *          background color for normal state
 * @param   SelectedBgColor
 *          background color when the item is selected
 */

- (YJMenuItem *)initWithItemTitle:(NSString *)title
                            Frame:(CGRect)frame
                          BgColor:(UIColor *)bgColor
                  SelectedBgColor:(UIColor *)selectedBgColor
                ItemSelectedIndex:(NSNumber *)itemSelectedIndex
                 NotificationName:(NSString *)name;
@end