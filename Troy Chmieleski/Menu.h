//
//  Menu.h
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/8/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Menu;

@protocol MenuDataSource <NSObject>

- (NSInteger)numberOfSectionsInMenuTableView:(UITableView *)menuTableView;
- (NSInteger)menuTableView:(UITableView *)menuTableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)menuTableView:(UITableView *)menuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol MenuDelegate <NSObject>

- (CGFloat)widthForMenu:(Menu *)menu;
- (CGFloat)heightForMenu:(Menu *)menu;
- (CGFloat)verticalTopMarginForMenu:(Menu *)menu;
- (CGFloat)menuTableView:(UITableView *)menuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)menuTableView:(UITableView *)menuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface Menu : UIWindow

@property (weak) id <MenuDataSource> menuDataSource;
@property (weak) id <MenuDelegate> menuDelegate;

@property (nonatomic, strong) UITableView *menuTableView;

- (void)show;

@end
