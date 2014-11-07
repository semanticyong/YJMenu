//
//  ViewController.m
//  YJMenuDemo
//
//  Created by yong on 10/27/14.
//  Copyright (c) 2014 yong. All rights reserved.
//

#import "ViewController.h"
#import "YJMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //we are creating 2 separate menus, each has 2 menu items
    //if u want combine them into one, just use the same 'NotificationName'
    
    // YJMenuStyleVertical, With Separator
    UILabel *labelForMenuWithSeparator = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 150, 30)];
    labelForMenuWithSeparator.text = @"With Separator";
    [self.view addSubview:labelForMenuWithSeparator];
    
    UIView *menuItemSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
    menuItemSeparatorView.backgroundColor = [UIColor grayColor];
    
    YJMenu *menu = [[YJMenu alloc] initWithMenuFrame:CGRectMake(50, 150, 100, 80)
                                           MenuStyle:YJMenuStyleVertical
                                          ItemTitles:@[@"hi1",@"hi2"]
                                  ItemSelectedIndexs:@[@(1), @(2)]
                               MenuItemSeparatorView:menuItemSeparatorView
                                             BgColor:nil
                                     SelectedBgColor:[UIColor redColor]
                                    NotificationName:@"itemSelected12"];
    
    menu.layer.borderColor = [UIColor blackColor].CGColor;
    menu.layer.borderWidth = 1.0f;
    [self.view addSubview:menu];
    
    // YJMenuStyleVertical, Without Separator
    UILabel *labelForMenuWithoutSeparator = [[UILabel alloc] initWithFrame:CGRectMake(200, 100, 150, 30)];
    labelForMenuWithoutSeparator.text = @"Without Separator";
    [self.view addSubview:labelForMenuWithoutSeparator];
    
    YJMenu *menuWithoutSeparator = [[YJMenu alloc] initWithMenuFrame:CGRectMake(200, 150, 100, 80)
                                                           MenuStyle:YJMenuStyleVertical
                                                          ItemTitles:@[@"hi5",@"hi6"]
                                                  ItemSelectedIndexs:@[@(5), @(6)]
                                               MenuItemSeparatorView:nil
                                                             BgColor:nil
                                                     SelectedBgColor:[UIColor redColor]
                                                    NotificationName:@"itemSelected56"];
    
    menuWithoutSeparator.layer.borderColor = [UIColor blackColor].CGColor;
    menuWithoutSeparator.layer.borderWidth = 1.0f;
    [self.view addSubview:menuWithoutSeparator];
    
    // YJMenuStyleHorizontal, Without Separator
    UILabel *labelForMenuWithSeparatorHorizontal = [[UILabel alloc] initWithFrame:CGRectMake(30, 260, 150, 30)];
    labelForMenuWithSeparatorHorizontal.text = @"With Separator";
    [self.view addSubview:labelForMenuWithSeparatorHorizontal];
    
    YJMenu *menuHorizontal = [[YJMenu alloc] initWithMenuFrame:CGRectMake(50, 300, 200, 30)
                                                     MenuStyle:YJMenuStyleHorizontal
                                                    ItemTitles:@[@"hi7",@"hi8"]
                                            ItemSelectedIndexs:@[@(7), @(8)]
                                         MenuItemSeparatorView:nil
                                                       BgColor:nil
                                               SelectedBgColor:[UIColor redColor]
                                              NotificationName:@"itemSelected13"];
    
    menuHorizontal.layer.borderColor = [UIColor blackColor].CGColor;
    menuHorizontal.layer.borderWidth = 1.0f;
    [self.view addSubview:menuHorizontal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
