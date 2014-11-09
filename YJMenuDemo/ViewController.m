//
//  ViewController.m
//  YJMenuDemo
//
//  Created by yong on 10/27/14.
//  Copyright (c) 2014 yong. All rights reserved.
//

#import "ViewController.h"
#import "YJMenu.h"
#import "YJMenuItem.h"

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
                                          ItemTitles:@[@"MI11",@"MI12"]
                                  ItemSelectedIndexs:@[@(1), @(2)]
                               MenuItemSeparatorView:menuItemSeparatorView
                                             BgColor:nil
                                     SelectedBgColor:[UIColor redColor]
                                    NotificationName:@"Menu1_itemSelected"];
    
    menu.layer.borderColor = [UIColor blackColor].CGColor;
    menu.layer.borderWidth = 1.0f;
    [self.view addSubview:menu];
    
    // YJMenuStyleVertical, Without Separator
    UILabel *labelForMenuWithoutSeparator = [[UILabel alloc] initWithFrame:CGRectMake(200, 100, 150, 30)];
    labelForMenuWithoutSeparator.text = @"Without Separator";
    [self.view addSubview:labelForMenuWithoutSeparator];
    
    YJMenu *menuWithoutSeparator = [[YJMenu alloc] initWithMenuFrame:CGRectMake(200, 150, 100, 80)
                                                           MenuStyle:YJMenuStyleVertical
                                                          ItemTitles:@[@"MI21",@"MI22"]
                                                  ItemSelectedIndexs:@[@(1), @(2)]
                                               MenuItemSeparatorView:nil
                                                             BgColor:nil
                                                     SelectedBgColor:[UIColor redColor]
                                                    NotificationName:@"Menu2_itemSelected"];
    
    menuWithoutSeparator.layer.borderColor = [UIColor blackColor].CGColor;
    menuWithoutSeparator.layer.borderWidth = 1.0f;
    [self.view addSubview:menuWithoutSeparator];
    
    // YJMenuStyleHorizontal, Without Separator
    UILabel *labelForMenuWithSeparatorHorizontal = [[UILabel alloc] initWithFrame:CGRectMake(30, 260, 260, 30)];
    labelForMenuWithSeparatorHorizontal.text = @"Horizontal, Without Separator";
    labelForMenuWithSeparatorHorizontal.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:labelForMenuWithSeparatorHorizontal];
    
    YJMenu *menuHorizontal = [[YJMenu alloc] initWithMenuFrame:CGRectMake(30, 300, 260, 30)
                                                     MenuStyle:YJMenuStyleHorizontal
                                                    ItemTitles:@[@"MI31",@"MI32",@"MI33"]
                                            ItemSelectedIndexs:@[@(1), @(2), @(3)]
                                         MenuItemSeparatorView:nil
                                                       BgColor:nil
                                               SelectedBgColor:[UIColor redColor]
                                              NotificationName:@"Menu3_itemSelected"];
    
    menuHorizontal.layer.borderColor = [UIColor blackColor].CGColor;
    menuHorizontal.layer.borderWidth = 1.0f;
    [self.view addSubview:menuHorizontal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRecievedForMenu1:) name:@"Menu1_itemSelected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRecievedForMenu2:) name:@"Menu2_itemSelected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRecievedForMenu3:) name:@"Menu3_itemSelected" object:nil];
}

- (void)notificationRecievedForMenu1:(NSNotification *)notification
{
    NSDictionary * dict = notification.userInfo;
    NSNumber *index = dict[ItemSelectedIndexKey];
    switch ([index integerValue]) {
        case 1:
            NSLog(@"MI11 Selected");
            break;
            
        case 2:
            NSLog(@"MI12 Selected");
            break;
            
        case 3:
            NSLog(@"MI13 Selected");
            break;
            
        default:
            break;
    }
}

- (void)notificationRecievedForMenu2:(NSNotification *)notification
{
    NSDictionary * dict = notification.userInfo;
    NSNumber *index = dict[ItemSelectedIndexKey];
    switch ([index integerValue]) {
        case 1:
            NSLog(@"MI21 Selected");
            break;
            
        case 2:
            NSLog(@"MI22 Selected");
            break;
            
        case 3:
            NSLog(@"MI23 Selected");
            break;
            
        default:
            break;
    }
}

- (void)notificationRecievedForMenu3:(NSNotification *)notification
{
    NSDictionary * dict = notification.userInfo;
    NSNumber *index = dict[ItemSelectedIndexKey];
    switch ([index integerValue]) {
        case 1:
            NSLog(@"MI31 Selected");
            break;
            
        case 2:
            NSLog(@"MI32 Selected");
            break;
            
        case 3:
            NSLog(@"MI33 Selected");
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
