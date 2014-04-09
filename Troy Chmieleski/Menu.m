//
//  Menu.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/8/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "Menu.h"

// Menu background view
#define MENU_BACKGROUND_VIEW_OPACITY 0.6f

@interface Menu () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIView *menuBackgroundView;

@end

@implementation Menu

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
	
    if (self) {
		[self setWindowLevel:UIWindowLevelStatusBar];
		[self makeKeyAndVisible];
		
		[self addSubview:self.menuBackgroundView];
		//[self addSubview:self.menuView];
		[self addSubview:self.menuTableView];
		
		[self hide];
    }
	
    return self;
}

#pragma mark - Show 

- (void)show {
	[self setHidden:NO];
}

#pragma mark - Hide

- (void)hide {
	[self setHidden:YES];
}

#pragma mark - Menu tableview

- (UITableView *)menuTableView {
	if (!_menuTableView) {
		_menuTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		[_menuTableView setDataSource:self];
		[_menuTableView setDelegate:self];
	}
	
	return _menuTableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSInteger numberOfSections = 0;
	
	if ([self.menuDataSource respondsToSelector:@selector(numberOfSectionsInMenuTableView:)]) {
		numberOfSections = [self.menuDataSource numberOfSectionsInMenuTableView:self.menuTableView];
	}
	
	return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
	
	if ([self.menuDataSource respondsToSelector:@selector(menuTableView:numberOfRowsInSection:)]) {
		numberOfRows = [self.menuDataSource menuTableView:self.menuTableView numberOfRowsInSection:section];
	}
	
	return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
	
	if ([self.menuDataSource respondsToSelector:@selector(menuTableView:cellForRowAtIndexPath:)]) {
		cell = [self.menuDataSource menuTableView:self.menuTableView cellForRowAtIndexPath:indexPath];
	}
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat rowHeight = 0;
	
	if ([self.menuDelegate respondsToSelector:@selector(menuTableView:heightForRowAtIndexPath:)]) {
		rowHeight = [self.menuDelegate menuTableView:self.menuTableView heightForRowAtIndexPath:indexPath];
	}
	
	return rowHeight;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.menuDelegate respondsToSelector:@selector(menuTableView:didSelectRowAtIndexPath:)]) {
		[self.menuDelegate menuTableView:self.menuTableView didSelectRowAtIndexPath:indexPath];
	}
}

#pragma mark - Menu view

- (UIView *)menuView {
	if (!_menuView) {
		_menuView = [[UIView alloc] initWithFrame:CGRectZero];
		[_menuView setBackgroundColor:[UIColor whiteColor]];
	}
	
	return _menuView;
}

#pragma mark - Menu background view

- (UIView *)menuBackgroundView {
	if (!_menuBackgroundView) {
		_menuBackgroundView = [[UIView alloc] initWithFrame:self.frame];
		[_menuBackgroundView setBackgroundColor:[UIColor blackColor]];
		[_menuBackgroundView setAlpha:MENU_BACKGROUND_VIEW_OPACITY];
	}
	
	return _menuBackgroundView;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	// menu view
	CGFloat menuWidth = 0;
	CGFloat menuHeight = 0;
	CGFloat menuTopVerticalMargin = 0;
	
	if ([self.menuDelegate respondsToSelector:@selector(widthForMenu:)]) {
		menuWidth = [self.menuDelegate widthForMenu:self];
	}
	
	if ([self.menuDelegate respondsToSelector:@selector(heightForMenu:)]) {
		menuHeight = [self.menuDelegate heightForMenu:self];
	}
	
	if ([self.menuDelegate respondsToSelector:@selector(verticalTopMarginForMenu:)]) {
		menuTopVerticalMargin = [self.menuDelegate verticalTopMarginForMenu:self];
	}
	
	[self.menuView setFrame:CGRectMake(0, menuTopVerticalMargin, menuWidth, menuHeight)];
	[self.menuTableView setFrame:CGRectMake(0, menuTopVerticalMargin, menuWidth, menuHeight)];
}

@end
