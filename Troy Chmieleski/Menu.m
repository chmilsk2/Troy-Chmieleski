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

// Menu animation
#define MENU_ANIMATION_DURATION 0.3f

@interface Menu () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIView *menuBackgroundView;
@property (nonatomic, strong) UITapGestureRecognizer *backgroundTapGestureRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *menuPanGestureRecognizer;

@end

@implementation Menu {
	BOOL _isShowing;
	BOOL _isHiding;
	BOOL _isPanning;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
	
    if (self) {
		[self setWindowLevel:UIWindowLevelStatusBar];
		[self makeKeyAndVisible];
		
		[self addSubview:self.menuBackgroundView];
		[self addSubview:self.menuView];
		
		[self setHidden:YES];
    }
	
    return self;
}

#pragma mark - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if ([self.menuDelegate respondsToSelector:@selector(menu:scrollViewDidScroll:)]) {
		[self.menuDelegate menu:self scrollViewDidScroll:scrollView];
	}
}

#pragma mark - Gesture recognizers

- (void)backgroundTapped:(UITapGestureRecognizer *)tapGestureRecognizer {	
	if (!_isPanning) {
		[self hide];
	}
}

- (void)menuPanned:(UIPanGestureRecognizer *)panGestureRecognizer {
	NSLog(@"menu panned");
	
	if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
		_isPanning = YES;
	}
	
	CGPoint velocity = [panGestureRecognizer velocityInView:panGestureRecognizer.view];
	CGPoint translation = [panGestureRecognizer translationInView:panGestureRecognizer.view];
	
	CGRect frame = panGestureRecognizer.view.frame;
	frame.origin.x = (translation.x < 0) ? translation.x: 0;
	[panGestureRecognizer.view setFrame:frame];
	
	if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
		if (velocity.x < 0) {
			[self hide];
		}
		
		else {
			[self show];
		}
		
		_isPanning = NO;
	}
}

#pragma mark - Show 

- (void)show {
	_isShowing = YES;
	
	[self setHidden:NO];
	
	[UIView animateWithDuration:MENU_ANIMATION_DURATION animations:^{
		CGRect menuViewFrame = self.menuView.frame;
		menuViewFrame.origin.x = 0;
		[self.menuView setFrame:menuViewFrame];
		[self.menuBackgroundView setAlpha:MENU_BACKGROUND_VIEW_OPACITY];
	}];
	
	NSTimer *animationTimer = [NSTimer timerWithTimeInterval:MENU_ANIMATION_DURATION target:self selector:@selector(finishedAnimation:) userInfo:nil repeats:NO];
	[[NSRunLoop currentRunLoop] addTimer:animationTimer forMode:NSRunLoopCommonModes];
}

#pragma mark - Hide

- (void)hide {
	_isHiding = YES;
	
	[UIView animateWithDuration:MENU_ANIMATION_DURATION animations:^{
		CGRect menuViewFrame = self.menuView.frame;
		menuViewFrame.origin.x = -self.menuView.frame.size.width;
		[self.menuView setFrame:menuViewFrame];
		[self.menuBackgroundView setAlpha:0];
	}];
	
	NSTimer *animationTimer = [NSTimer timerWithTimeInterval:MENU_ANIMATION_DURATION target:self selector:@selector(finishedAnimation:) userInfo:nil repeats:NO];
	[[NSRunLoop currentRunLoop] addTimer:animationTimer forMode:NSRunLoopCommonModes];
}

#pragma mark - Animation finished

- (void)finishedAnimation:(NSTimer *)timer {
	if (_isShowing) {
		_isShowing = NO;
	}
	
	else if (_isHiding) {
		self.hidden = YES;
		_isHiding = NO;
	}
}

#pragma mark - Menu tableview

- (UITableView *)menuTableView {
	if (!_menuTableView) {
		_menuTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		
		UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Earth"]];
		[backgroundImageView setContentMode:UIViewContentModeTopLeft];
		
		[_menuTableView setBackgroundView:backgroundImageView];
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
		[_menuView addGestureRecognizer:self.menuPanGestureRecognizer];
		
		[_menuView addSubview:self.menuTableView];
	}
	
	return _menuView;
}

#pragma mark - Menu pan gesture recognizer

- (UIPanGestureRecognizer *)menuPanGestureRecognizer {
	if (!_menuPanGestureRecognizer) {
		_menuPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(menuPanned:)];
	}
	
	return _menuPanGestureRecognizer;
}

#pragma mark - Menu background view

- (UIView *)menuBackgroundView {
	if (!_menuBackgroundView) {
		_menuBackgroundView = [[UIView alloc] initWithFrame:self.frame];
		[_menuBackgroundView addGestureRecognizer:self.backgroundTapGestureRecognizer];
		[_menuBackgroundView setBackgroundColor:[UIColor blackColor]];
		[_menuBackgroundView setAlpha:0];
	}
	
	return _menuBackgroundView;
}

#pragma mark - Background tap gesture recognizer

- (UITapGestureRecognizer *)backgroundTapGestureRecognizer {
	if (!_backgroundTapGestureRecognizer) {
		_backgroundTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
	}
	
	return _backgroundTapGestureRecognizer;
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
	
	CGFloat xPos = -menuWidth;
	
	if (!self.hidden) {
		xPos = 0;
	}
	
	// menu view
	[self.menuView setFrame:CGRectMake(xPos, menuTopVerticalMargin, menuWidth, menuHeight)];
	[self.menuTableView setFrame:self.menuView.bounds];
}

@end
