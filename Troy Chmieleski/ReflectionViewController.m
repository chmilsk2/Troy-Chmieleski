//
//  ReflectionViewController.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/6/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "ReflectionViewController.h"

// Menu
#import "Menu.h"

// Menu profile cell
#import "MenuProfileCell.h"

// Menu cell
#import "MenuCell.h"

// Experience reflection
#import "ExperienceReflection.h"

// Education reflection
#import "EducationReflection.h"

// Experience reflection cell
#import "ExperienceReflectionCell.h"

// Education reflection cell
#import "EducationReflectionCell.h"

typedef NS_ENUM(NSUInteger, MenuSectionType) {
	MenuSectionTypeProfile = 0,
	MenuSectionTypeItem = 1
};

typedef NS_ENUM(NSInteger, MenuItemType) {
	MenuItemTypeAll = 0,
	MenuItemTypeGoals = 1,
	MenuItemTypeExperience = 2,
	MenuItemTypeEducation = 3,
	MenuItemTypeLeadershipAndActivities = 4,
	MenuItemTypeSkills = 5
};

// Google Analytics
#define SCREEN_NAME @"Reflection Screen"

#define ExperienceReflectionCellIdentifier @"Experience Reflection Cell Identifier"
#define EducationReflectionCellIdentifier @"Education Reflection Cell Identifier"
#define ReflectionPaddingCellIdentifier @"Reflection Padding Cell Identifier"

#define NUMBER_OF_SECTIONS 4
#define SECTION_HEADER_HORIZONTAL_MARGIN 14.0f
#define SECTION_HEADER_VERTICAL_MARGIN 10.0f
#define SECTION_HEADER_BACKGROUND_OPACITY 1.0f
#define SECTION_HEADER_EXPERIENCE_TITLE @"EXPERIENCE"
#define SECTION_HEADER_EDUCATION_TITLE @"EDUCATION"
#define SECTION_HEADER_LEADERSHIP_AND_ACTIVITIES_TITLE @"LEADERSHIP & ACTIVITIES"
#define SECTION_HEADER_SKILLS_TITLE @"SKILLS"

#define REFLECTION_CELL_PADDING_ROW_HEIGHT 6.0f

// Menu
#define MenuProfileCellReuseIdentifier @"Menu Profile Cell Reuse Identifier"
#define MenuCellReuseIdentifier @"Menu Cell Reuse Identifier"

// Menu profile cell
#define MENU_PROFILE_ROW_HEIGHT 100.0f

// Menu cell
#define MENU_ITEM_ROW_HEIGHT 60.0f

#define MENU_HORIZONTAL_MARGIN 40.0f
#define MENU_NUMBER_OF_SECTIONS 2
#define MENU_NUMBER_OF_PROFILE_ROWS 1
#define MENU_ITEM_ALL @"ALL"
#define MENU_ITEM_GOALS @"GOALS"
#define MENU_ITEM_EXPERIENCE @"EXPERIENCE"
#define MENU_ITEM_EDUCATION @"EDUCATION"
#define MENU_ITEM_LEADERSHIP_AND_ACTIVITIES @"LEADERSHIP & ACTIVITIES"
#define MENU_ITEM_SKILLS @"SKILLS"

// Menu button
#define MENU_BUTTON_HORIZONTAL_MARGIN 14.0f
#define MENU_BUTTON_VERTICAL_MARGIN 14.0f
#define MENU_BUTTON_SIZE 44.0f
#define MENU_BUTTON_IMAGE_NAME @"MenuButton"

// Compose goal button
#define COMPOSE_GOAL_BUTTON_HORIZONTAL_MARGIN 14.0f
#define COMPOSE_GOAL_BUTTON_VERTICAL_MARGIN 14.0f
#define COMPOSE_GOAL_BUTTON_SIZE 44.0f
#define COMPOSE_GOAL_BUTTON_IMAGE_NAME @"ComposeGoalButton"

// Screen dimensions
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// Status bar height
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

typedef NS_ENUM(NSInteger, SectionType) {
	SectionTypeExperience = 0,
	SectionTypeEducation = 1,
	SectionTypeLeadershipAndActivities = 2,
	SectionTypeSkills = 3
};

@interface ReflectionViewController () <ReflectionCelDelegate, MenuDataSource, MenuDelegate>

@property (nonatomic, strong) NSMutableArray *experienceReflections;
@property (nonatomic, strong) NSMutableArray *educationReflections;
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) Menu *menu;
@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) UIButton *composeGoalButton;

@end

@implementation ReflectionViewController

- (id)init {
    self = [super init];
	
    if (self) {
		// Google Analytics
        [self setScreenName:SCREEN_NAME];
		
		[self setUpMenu];
		
		[self setUpExperienceReflections];
		[self setUpEducationReflections];
		[self setUpLeadershipAndActivitiesReflections];
		[self setUpSkillsReflections];
		
		[self setUpReflectionTableView];
		
		[self.view addSubview:self.reflectionTableView];
		[self.view addSubview:self.menuButton];
		[self.view addSubview:self.composeGoalButton];
		
		[self.menu show];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentSizeDidChange:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
	
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	NSArray *visibleCells = [self.reflectionTableView visibleCells];
	
	for (ReflectionCell *visibleCell in visibleCells) {
		[visibleCell setNeedsLayout];
	}
}

- (void)setUpReflectionTableView {
	[self.reflectionTableView registerClass:[ExperienceReflectionCell class] forCellReuseIdentifier:ExperienceReflectionCellIdentifier];
	[self.reflectionTableView registerClass:[EducationReflectionCell class] forCellReuseIdentifier:EducationReflectionCellIdentifier];
	[self.reflectionTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReflectionPaddingCellIdentifier];
	[self.reflectionTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)setUpMenu {
	[self.menu.menuTableView registerClass:[MenuProfileCell class] forCellReuseIdentifier:MenuProfileCellReuseIdentifier];
	[self.menu.menuTableView registerClass:[MenuCell class] forCellReuseIdentifier:MenuCellReuseIdentifier];
	
	[self.menu.menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	
	_menuItems = @[@(MenuItemTypeAll), @(MenuItemTypeGoals), @(MenuItemTypeExperience), @(MenuItemTypeEducation), @(MenuItemTypeLeadershipAndActivities), @(MenuItemTypeSkills)];
}

- (void)setUpExperienceReflections {
	_experienceReflections = [[NSMutableArray alloc] init];
	
	ExperienceReflection *iOSInternExperienceReflection = [[ExperienceReflection alloc] init];
	[iOSInternExperienceReflection setEmployer:@"DONEBOX"];
	[iOSInternExperienceReflection setTitle:@"iOS Intern"];
	[iOSInternExperienceReflection setDescription:@"Developing an app that links together email, calendars and todos"];
	[iOSInternExperienceReflection setLocation:@"Cambridge, MA"];
	[iOSInternExperienceReflection setDate:@"June '13 - Present"];
	
	ExperienceReflection *uiucTinnitusLabIOSDeveloperExperienceReflection = [[ExperienceReflection alloc] init];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setEmployer:@"UIUC TINNITUS LAB"];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setTitle:@"iOS Developer"];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setDescription:@"Designing fractal tone therapy for Tinnitus that leverages the power of Core Audio"];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setLocation:@"Urbana, IL"];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setDate:@"April '13 - Present"];
	
	ExperienceReflection *citesOnsiteConsultantExperienceReflection = [[ExperienceReflection alloc] init];
	[citesOnsiteConsultantExperienceReflection setEmployer:@"CITES ONSITE CONSULTING"];
	[citesOnsiteConsultantExperienceReflection setTitle:@"Computer Consultant"];
	[citesOnsiteConsultantExperienceReflection setDescription:@"Facilitated on-site computer consulting services in both home and enterprise environments"];
	[citesOnsiteConsultantExperienceReflection setLocation:@"Urbana, IL"];
	[citesOnsiteConsultantExperienceReflection setDate:@"September '12 - May '13"];
	
	ExperienceReflection *universityRelationsOfficeAssistantExperienceReflection = [[ExperienceReflection alloc] init];
	[universityRelationsOfficeAssistantExperienceReflection setEmployer:@"UNIVERSITY RELATIONS"];
	[universityRelationsOfficeAssistantExperienceReflection setTitle:@"Office Assistant"];
	[universityRelationsOfficeAssistantExperienceReflection setDescription:@"Updated official records and PrezRelease, the blog of the University of Illinois president"];
	[universityRelationsOfficeAssistantExperienceReflection setLocation:@"Urbana, IL"];
	[universityRelationsOfficeAssistantExperienceReflection setDate:@"February '12 - May '12"];
	
	[_experienceReflections addObjectsFromArray:@[iOSInternExperienceReflection, uiucTinnitusLabIOSDeveloperExperienceReflection, citesOnsiteConsultantExperienceReflection, universityRelationsOfficeAssistantExperienceReflection]];
}

- (void)setUpEducationReflections {
	_educationReflections = [NSMutableArray array];
	
	EducationReflection *universityReflection = [[EducationReflection alloc] init];
	[universityReflection setSchool:@"UIUC"];
	[universityReflection setDegree:@"B.S. in E.E., Minor in C.S."];
	[universityReflection setExpectedGraduationDate:@"May '15"];
	[universityReflection setGpa:@"GPA: 3.65/4.00"];
	
	[_educationReflections addObjectsFromArray:@[universityReflection]];
}

- (void)setUpLeadershipAndActivitiesReflections {
	
}

- (void)setUpSkillsReflections {
	
}

#pragma mark - Reflection cell delegate

- (CGPoint)contentOffsetForReflectionCell:(ReflectionCell *)reflectionCell {
	CGRect reflectionCellRect = [self.reflectionTableView rectForRowAtIndexPath:[self.reflectionTableView indexPathForCell:reflectionCell]];
	
	CGPoint contentOffset = CGPointMake(reflectionCellRect.origin.x, self.reflectionTableView.contentOffset.y - reflectionCellRect.origin.y);
	
	return contentOffset;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return NUMBER_OF_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger numberOfRows = 0;
	
	if (section == SectionTypeExperience) {
		numberOfRows = _experienceReflections.count;
	}
	
	else if (section == SectionTypeEducation) {
		numberOfRows = _educationReflections.count;
	}
	
	else if (section == SectionTypeLeadershipAndActivities) {
		numberOfRows = 0;
	}
	
	else if (section == SectionTypeSkills) {
		numberOfRows = 0;
	}
	
	numberOfRows = numberOfRows*2;
	
	return numberOfRows;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	CGFloat sectionHeaderHeight = [self tableView:tableView heightForHeaderInSection:section];
	
	UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, sectionHeaderHeight)];
	
	UIView *sectionHeaderBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, sectionHeaderHeight)];
	[sectionHeaderBackgroundView setBackgroundColor:[UIColor whiteColor]];
	
	NSString *sectionHeader= [self sectionHeaderForSectionType:section];
	
	CGRect sectionHeaderRect = [self sectionHeaderRectForSectionHeader:sectionHeader];
	
	UILabel *sectionHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(SECTION_HEADER_HORIZONTAL_MARGIN, SECTION_HEADER_VERTICAL_MARGIN, sectionHeaderRect.size.width, sectionHeaderRect.size.height)];
	[sectionHeaderLabel setText:sectionHeader];
	[sectionHeaderLabel setTextColor:[UIColor blackColor]];
	[sectionHeaderLabel setFont:[self sectionHeaderFont]];
	
	[sectionHeaderView addSubview:sectionHeaderBackgroundView];
	[sectionHeaderView addSubview:sectionHeaderLabel];
	
	return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;
	
	if (indexPath.row % 2 == 0) {
		ReflectionCell *reflectionCell;
		
		if (indexPath.section == SectionTypeExperience) {
			ExperienceReflectionCell *experienceReflectionCell = [self.reflectionTableView dequeueReusableCellWithIdentifier:ExperienceReflectionCellIdentifier forIndexPath:indexPath];
			
			[self configureExperienceReflectionCell:experienceReflectionCell forRowAtIndexPath:indexPath];
			
			reflectionCell = experienceReflectionCell;
		}
		
		else if (indexPath.section == SectionTypeEducation) {
			EducationReflectionCell *educationReflectionCell = [self.reflectionTableView dequeueReusableCellWithIdentifier:EducationReflectionCellIdentifier forIndexPath:indexPath];
			
			[self configureEducationReflectionCell:educationReflectionCell forRowAtIndexPath:indexPath];
			
			reflectionCell = educationReflectionCell;
		}
		
		else if (indexPath.section == SectionTypeLeadershipAndActivities) {
			
		}
		
		else if (indexPath.section == SectionTypeSkills) {
			
		}
		
		[reflectionCell setDelegate:self];
		[self configureReflectionCell:reflectionCell forRowAtIndexPath:indexPath];
		cell = reflectionCell;
	}
	
	else {
		cell = [tableView dequeueReusableCellWithIdentifier:ReflectionPaddingCellIdentifier forIndexPath:indexPath];
	}
	
    return cell;
}

- (void)configureReflectionCell:(ReflectionCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *imageName;
	
	NSUInteger numberOfBackgroundImages = 4;
	
	if ([self reflectionCellIndexForIndexPath:indexPath] % numberOfBackgroundImages == 0) {
		imageName = @"rainbowApple";
	}
	
	else if ([self reflectionCellIndexForIndexPath:indexPath] % numberOfBackgroundImages == 1){
		imageName = @"bmw";
	}
	
	else if ([self reflectionCellIndexForIndexPath:indexPath] % numberOfBackgroundImages == 2) {
		imageName = @"clownFish";
	}
	
	else if ([self reflectionCellIndexForIndexPath:indexPath] % numberOfBackgroundImages == 3) {
		imageName = @"sky";
	}
	
	[cell setReflectionBackgroundViewImage:[UIImage imageNamed:imageName]];
}

- (void)configureExperienceReflectionCell:(ExperienceReflectionCell *)experienceReflectionCell forRowAtIndexPath:(NSIndexPath *)indexPath {
	ExperienceReflection *experienceReflection = _experienceReflections[[self reflectionCellIndexForIndexPath:indexPath]];
	
	[experienceReflectionCell.employerLabel setText:experienceReflection.employer];
	[experienceReflectionCell.titleLabel setText:experienceReflection.title];
	[experienceReflectionCell.locationLabel setText:experienceReflection.location];
	[experienceReflectionCell.dateLabel setText:experienceReflection.date];
	[experienceReflectionCell.descriptionLabel setText:experienceReflection.description];
}

- (void)configureEducationReflectionCell:(EducationReflectionCell *)educationReflectionCell forRowAtIndexPath:(NSIndexPath *)indexPath {
	EducationReflection *educationReflection = _educationReflections[[self reflectionCellIndexForIndexPath:indexPath]];
	
	[educationReflectionCell.schoolLabel setText:educationReflection.school];
	[educationReflectionCell.degreeLabel setText:educationReflection.degree];
	[educationReflectionCell.expectedGraduationDateLabel setText:educationReflection.expectedGraduationDate];
	[educationReflectionCell.gpaLabel setText:educationReflection.gpa];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	CGFloat sectionHeaderHeight = 0;
	
	SectionType sectionType = section;
	
	NSString *sectionHeader = [self sectionHeaderForSectionType:sectionType];
	
	CGRect sectionHeaderRect = [self sectionHeaderRectForSectionHeader:sectionHeader];

	sectionHeaderHeight += SECTION_HEADER_VERTICAL_MARGIN;

	sectionHeaderHeight += sectionHeaderRect.size.height;
	
	sectionHeaderHeight += SECTION_HEADER_VERTICAL_MARGIN;
	
	return sectionHeaderHeight;
}

- (NSString *)sectionHeaderForSectionType:(SectionType)sectionType {
	NSString *sectionHeader;
	
	if (sectionType == SectionTypeExperience) {
		sectionHeader = SECTION_HEADER_EXPERIENCE_TITLE;
	}
	
	else if (sectionType == SectionTypeEducation) {
		sectionHeader = SECTION_HEADER_EDUCATION_TITLE;
	}
	
	else if (sectionType == SectionTypeLeadershipAndActivities) {
		sectionHeader = SECTION_HEADER_LEADERSHIP_AND_ACTIVITIES_TITLE;
	}
	
	else if (sectionType == SectionTypeSkills) {
		sectionHeader = SECTION_HEADER_SKILLS_TITLE;
	}
		
	return sectionHeader;
}

- (CGRect)sectionHeaderRectForSectionHeader:(NSString *)sectionHeader {
	CGRect sectionHeaderRect = CGRectIntegral([sectionHeader boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self sectionHeaderFont]} context:nil]);
	
	return sectionHeaderRect;
}

- (UIFont *)sectionHeaderFont {
	UIFont *sectionHeaderFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
	
	return sectionHeaderFont;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat rowHeight = 0;
	
	if (indexPath.row % 2 == 0) {
		if (indexPath.section == SectionTypeExperience) {
			ExperienceReflection *experienceReflection = _experienceReflections[[self reflectionCellIndexForIndexPath:indexPath]];
			
			ExperienceReflectionCell *prototypicalExperienceReflectionCell = [self.reflectionTableView dequeueReusableCellWithIdentifier:ExperienceReflectionCellIdentifier];
			
			rowHeight = [prototypicalExperienceReflectionCell heightForExperienceReflection:experienceReflection];
		}
		
		else if (indexPath.section == SectionTypeEducation) {
			EducationReflection *educationReflection = _educationReflections[[self reflectionCellIndexForIndexPath:indexPath]];
			
			EducationReflectionCell *prototypicalEducationReflectionCell = [self.reflectionTableView dequeueReusableCellWithIdentifier:EducationReflectionCellIdentifier];
			
			rowHeight = [prototypicalEducationReflectionCell heightForEducationReflection:educationReflection];
		}
		
		else if (indexPath.section == SectionTypeLeadershipAndActivities) {
			
		}
		
		else if (indexPath.section == SectionTypeSkills) {
			
		}
		
		return rowHeight;
	}
	
	else {
		rowHeight = REFLECTION_CELL_PADDING_ROW_HEIGHT;
	}
	
	return rowHeight;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did select row at index path: %@", indexPath);
}

- (NSInteger)reflectionCellIndexForIndexPath:(NSIndexPath *)indexPath {
	NSIndexPath *reflectionCellIndexPath = [NSIndexPath indexPathForRow:indexPath.row/2 inSection:indexPath.section];
	
	return reflectionCellIndexPath.row;
}

#pragma mark - Reflection table view

- (UITableView *)reflectionTableView {
	if (!_reflectionTableView) {
		_reflectionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kScreenHeight - kStatusBarHeight) style:UITableViewStyleGrouped];
		[_reflectionTableView setDataSource:self];
		[_reflectionTableView setDelegate:self];
	}
	
	return _reflectionTableView;
}

#pragma mark - Menu

- (Menu *)menu {
	if (!_menu) {
		_menu = [[Menu alloc] initWithFrame:self.view.frame];
		[_menu setMenuDataSource:self];
		[_menu setMenuDelegate:self];
	}
	
	return _menu;
}

#pragma mark - Menu data source

- (NSInteger)numberOfSectionsInMenuTableView:(UITableView *)menuTableView {
	return MENU_NUMBER_OF_SECTIONS;
}

- (NSInteger)menuTableView:(UITableView *)menuTableView numberOfRowsInSection:(NSInteger)section {
	NSInteger numberOfRows = 0;
	
	if (section == MenuSectionTypeProfile) {
		numberOfRows = MENU_NUMBER_OF_PROFILE_ROWS;
	}
	
	else if (section == MenuSectionTypeItem) {
		numberOfRows = self.menuItems.count;
	}
	
	return numberOfRows;
}

- (UITableViewCell *)menuTableView:(UITableView *)menuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;
	
	if (indexPath.section == MenuSectionTypeProfile) {
		MenuProfileCell *menuProfileCell = [menuTableView dequeueReusableCellWithIdentifier:MenuProfileCellReuseIdentifier forIndexPath:indexPath];
		
		[self configureMenuProfileCell:menuProfileCell forRowAtIndexPath:indexPath];
		
		cell = menuProfileCell;
	}
	
	else if (indexPath.section == MenuSectionTypeItem) {
		MenuCell *menuCell = [menuTableView dequeueReusableCellWithIdentifier:MenuCellReuseIdentifier forIndexPath:indexPath];
		
		[self configureMenuCell:menuCell forRowAtIndexPath:indexPath];
		
		cell = menuCell;
	}
	
	return cell;
}

- (void)configureMenuProfileCell:(MenuProfileCell *)menuProfileCell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
}

- (void)configureMenuCell:(MenuCell *)menuCell forRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *menuItem = [self menuItemForMenuItemType:indexPath.row];
	
	[menuCell.itemLabel setText:menuItem];
}

#pragma mark - Menu delegate 

- (CGFloat)widthForMenu:(Menu *)menu {
	CGFloat menuWidth = 0;
	
	menuWidth = kScreenWidth - MENU_HORIZONTAL_MARGIN;
	
	return menuWidth;
}

- (CGFloat)heightForMenu:(Menu *)menu {
	CGFloat menuHeight = 0;
	
	menuHeight = kScreenHeight - kStatusBarHeight;
	
	return menuHeight;
}

- (CGFloat)verticalTopMarginForMenu:(Menu *)menu {
	CGFloat verticalMargin = 0;
	
	verticalMargin = kStatusBarHeight;
	
	return verticalMargin;
}

- (CGFloat)menuTableView:(UITableView *)menuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat rowHeight = 0;
	
	if (indexPath.section == MenuSectionTypeProfile) {
		rowHeight = MENU_PROFILE_ROW_HEIGHT;
	}
	
	else if (indexPath.section == MenuSectionTypeItem) {
		rowHeight = MENU_ITEM_ROW_HEIGHT;
	}
	
	return rowHeight;
}

- (void)menuTableView:(UITableView *)menuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#warning TODO: imeplement this
}

#pragma mark - Menu item

- (NSString *)menuItemForMenuItemType:(MenuItemType)menuItemType {
	NSString *menuItem;
	
	if (menuItemType == MenuItemTypeAll) {
		menuItem = MENU_ITEM_ALL;
	}
	
	else if (menuItemType == MenuItemTypeGoals) {
		menuItem = MENU_ITEM_GOALS;
	}
	
	else if (menuItemType == MenuItemTypeExperience) {
		menuItem = MENU_ITEM_EXPERIENCE;
	}
	
	else if (menuItemType == MenuItemTypeEducation) {
		menuItem = MENU_ITEM_EDUCATION;
	}
	
	else if (menuItemType == MenuItemTypeLeadershipAndActivities) {
		menuItem = MENU_ITEM_LEADERSHIP_AND_ACTIVITIES;
	}
	
	else if (menuItemType == MenuItemTypeSkills) {
		menuItem = MENU_ITEM_SKILLS;
	}
	
	return menuItem;
}

#pragma mark - Menu Button

- (UIButton *)menuButton {
	if (!_menuButton) {
		_menuButton = [[UIButton alloc] initWithFrame:CGRectMake(MENU_BUTTON_HORIZONTAL_MARGIN, self.view.bounds.size.height - (MENU_BUTTON_SIZE + MENU_BUTTON_VERTICAL_MARGIN), MENU_BUTTON_SIZE, MENU_BUTTON_SIZE)];
		[_menuButton addTarget:self action:@selector(menuButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
		[_menuButton setBackgroundImage:[UIImage imageNamed:MENU_BUTTON_IMAGE_NAME] forState:UIControlStateNormal];
	}
	
	return _menuButton;
}

#pragma mark - Menu button touched

- (void)menuButtonTouched:(id)sender {
	NSLog(@"menu button touched");
}

#pragma mark - Compose goal button

- (UIButton *)composeGoalButton {
	if (!_composeGoalButton) {
		_composeGoalButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - (COMPOSE_GOAL_BUTTON_SIZE + COMPOSE_GOAL_BUTTON_HORIZONTAL_MARGIN), self.view.bounds.size.height - (COMPOSE_GOAL_BUTTON_SIZE + COMPOSE_GOAL_BUTTON_VERTICAL_MARGIN), COMPOSE_GOAL_BUTTON_SIZE, COMPOSE_GOAL_BUTTON_SIZE)];
		[_composeGoalButton addTarget:self action:@selector(composeGoalButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
		
//		[_composeGoalButton setBackgroundColor:[UIColor blackColor]];
//		[_composeGoalButton.layer setCornerRadius:44.0f/2];
		
		[_composeGoalButton setBackgroundImage:[UIImage imageNamed:COMPOSE_GOAL_BUTTON_IMAGE_NAME] forState:UIControlStateNormal];
	}
	
	return _composeGoalButton;
}

- (void)composeGoalButtonTouched:(id)sender {
	NSLog(@"compose goal button touched");
	
//	NSTimeInterval animationDuration = 0.4f;
//	
//	CABasicAnimation *cornerRadiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
//	cornerRadiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//	cornerRadiusAnimation.fromValue = [NSNumber numberWithFloat:44.0f/2];
//	cornerRadiusAnimation.toValue = [NSNumber numberWithFloat:0.0f];
//	cornerRadiusAnimation.duration = animationDuration;
//	[_composeGoalButton.layer setCornerRadius:0.0f];
//	[_composeGoalButton.layer addAnimation:cornerRadiusAnimation forKey:@"cornerRadius"];
//	
//	[UIView animateWithDuration:animationDuration animations:^{
//		[_composeGoalButton setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//		[_composeGoalButton setBackgroundColor:[UIColor whiteColor]];
//	}];
}

#pragma mark - Content size did change notification

- (void)contentSizeDidChange:(NSNotification *)notification {
	[self.reflectionTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
