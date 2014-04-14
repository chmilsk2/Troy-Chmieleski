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

// Reflection manager
#import "ReflectionManager.h"

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

// Leadership and activities reflection
#import "LeadershipAndActivitiesReflection.h"

// Leadership and activities reflection cell
#import "LeadershipAndActivitiesReflectionCell.h" 

// Skills reflection
#import "SkillsReflection.h"

// Skills reflection cell
#import "SkillsReflectionCell.h"

// Google Analytics
#define SCREEN_NAME @"Reflection Screen"

#define ExperienceReflectionCellIdentifier @"Experience Reflection Cell Identifier"
#define EducationReflectionCellIdentifier @"Education Reflection Cell Identifier"
#define LeadershipAndActivitiesReflectionCellIdentifier @"Leadership and Activities Reflection Cell Identifier"
#define SkillsReflectionCellIdentifier @"Skills Reflection Cell Identifier"
#define ReflectionPaddingCellIdentifier @"Reflection Padding Cell Identifier"

#define NUMBER_OF_SECTIONS 5
#define SECTION_HEADER_HORIZONTAL_MARGIN 14.0f
#define SECTION_HEADER_VERTICAL_MARGIN 10.0f
#define SECTION_HEADER_BACKGROUND_OPACITY 1.0f
#define SECTION_HEADER_GOALS_TITLE @"GOALS"
#define SECTION_HEADER_EXPERIENCE_TITLE @"EXPERIENCE"
#define SECTION_HEADER_EDUCATION_TITLE @"EDUCATION"
#define SECTION_HEADER_LEADERSHIP_AND_ACTIVITIES_TITLE @"LEADERSHIP & ACTIVITIES"
#define SECTION_HEADER_SKILLS_TITLE @"SKILLS"

#define REFLECTION_CELL_PADDING_ROW_HEIGHT 6.0f

// Menu
#define MenuProfileCellReuseIdentifier @"Menu Profile Cell Reuse Identifier"
#define MenuCellReuseIdentifier @"Menu Cell Reuse Identifier"

// Menu profile cell
#define MENU_PROFILE_ROW_HEIGHT 188.0f

// Menu cell
#define MENU_ITEM_ROW_HEIGHT 60.0f

#define MENU_HORIZONTAL_MARGIN 60.0f
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

// Reflections

typedef NS_ENUM(NSInteger, SectionType) {
	SectionTypeGoals = 0,
	SectionTypeExperience = 1,
	SectionTypeEducation = 2,
	SectionTypeLeadershipAndActivities = 3,
	SectionTypeSkills = 4
};

// Menu

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

@interface ReflectionViewController () <MenuProfileCellDelegate, ReflectionCelDelegate, MenuDataSource, MenuDelegate>

@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) Menu *menu;
@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) UIButton *composeGoalButton;

@end

@implementation ReflectionViewController {
	MenuItemType _selectedMenuItemType;
}

- (id)init {
    self = [super init];
	
    if (self) {
		// Google Analytics
        [self setScreenName:SCREEN_NAME];
		
		[self setUpMenu];
		
		[self setUpReflectionTableView];
		
		[self.view addSubview:self.reflectionTableView];
		[self.view addSubview:self.menuButton];
		[self.view addSubview:self.composeGoalButton];
		
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
	[self.reflectionTableView registerClass:[LeadershipAndActivitiesReflectionCell class] forCellReuseIdentifier:LeadershipAndActivitiesReflectionCellIdentifier];
	[self.reflectionTableView registerClass:[SkillsReflectionCell class] forCellReuseIdentifier:SkillsReflectionCellIdentifier];
	[self.reflectionTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReflectionPaddingCellIdentifier];
	[self.reflectionTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)setUpMenu {
	[self.menu.menuTableView registerClass:[MenuProfileCell class] forCellReuseIdentifier:MenuProfileCellReuseIdentifier];
	[self.menu.menuTableView registerClass:[MenuCell class] forCellReuseIdentifier:MenuCellReuseIdentifier];
	
	[self.menu.menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	
	_menuItems = @[@(MenuItemTypeAll), @(MenuItemTypeGoals), @(MenuItemTypeExperience), @(MenuItemTypeEducation), @(MenuItemTypeLeadershipAndActivities), @(MenuItemTypeSkills)];
	
	_selectedMenuItemType = MenuItemTypeAll;
}

#pragma mark - Reflection cell delegate

- (CGPoint)contentOffsetForReflectionCell:(ReflectionCell *)reflectionCell {
	CGRect reflectionCellRect = [self.reflectionTableView rectForRowAtIndexPath:[self.reflectionTableView indexPathForCell:reflectionCell]];
	
	CGPoint contentOffset = CGPointMake(reflectionCellRect.origin.x, self.reflectionTableView.contentOffset.y - reflectionCellRect.origin.y);
	
	return contentOffset;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numberOfSections = 0;
	
	if (_selectedMenuItemType == MenuItemTypeAll) {
		numberOfSections = NUMBER_OF_SECTIONS;
	}
	
	else {
		numberOfSections = 1;
	}
	
	return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger numberOfRows = 0;
	
	ReflectionManager *sharedReflectionManager = [ReflectionManager sharedReflectionManager];
	
	SectionType sectionType = [self sectionTypeForSection:section];
	
	CGFloat numberOfRowsInSection = 0;
	
	if (sectionType == SectionTypeGoals) {
		numberOfRowsInSection = sharedReflectionManager.goalsReflections.count;
	}
	
	else if (sectionType == SectionTypeExperience) {
		numberOfRowsInSection = sharedReflectionManager.experienceReflections.count;
	}
	
	else if (sectionType == SectionTypeEducation) {
		numberOfRowsInSection = sharedReflectionManager.educationReflections.count;
	}
	
	else if (sectionType == SectionTypeLeadershipAndActivities) {
		numberOfRowsInSection = sharedReflectionManager.leadershipAndActivitiesReflections.count;
	}
	
	else if (sectionType == SectionTypeSkills) {
		numberOfRowsInSection = sharedReflectionManager.skillsReflections.count;
	}
	
	numberOfRows += 2*numberOfRowsInSection;
	
	return numberOfRows;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	CGFloat sectionHeaderHeight = [self tableView:tableView heightForHeaderInSection:section];
	
	UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, sectionHeaderHeight)];
	
	UIView *sectionHeaderBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, sectionHeaderHeight)];
	[sectionHeaderBackgroundView setBackgroundColor:[UIColor whiteColor]];
	
	SectionType sectionType = [self sectionTypeForSection:section];
	
	NSString *sectionHeader= [self sectionHeaderForSectionType:sectionType];
	
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
		
		SectionType sectionType = [self sectionTypeForSection:indexPath.section];
		
		if (sectionType == SectionTypeGoals) {
			
		}
		
		if (sectionType == SectionTypeExperience) {
			ExperienceReflectionCell *experienceReflectionCell = [self.reflectionTableView dequeueReusableCellWithIdentifier:ExperienceReflectionCellIdentifier forIndexPath:indexPath];
			
			[self configureExperienceReflectionCell:experienceReflectionCell forRowAtIndexPath:indexPath];
			
			reflectionCell = experienceReflectionCell;
		}
		
		else if (sectionType == SectionTypeEducation) {
			EducationReflectionCell *educationReflectionCell = [self.reflectionTableView dequeueReusableCellWithIdentifier:EducationReflectionCellIdentifier forIndexPath:indexPath];
			
			[self configureEducationReflectionCell:educationReflectionCell forRowAtIndexPath:indexPath];
			
			reflectionCell = educationReflectionCell;
		}
		
		else if (sectionType == SectionTypeLeadershipAndActivities) {
			LeadershipAndActivitiesReflectionCell *leadershipAndActivitiesReflectionCell = [self.reflectionTableView dequeueReusableCellWithIdentifier:LeadershipAndActivitiesReflectionCellIdentifier forIndexPath:indexPath];
			
			[self configureLeadershipAndActivitiesReflectionCell:leadershipAndActivitiesReflectionCell forRowAtIndexPath:indexPath];
			
			reflectionCell = leadershipAndActivitiesReflectionCell;
		}
		
		else if (sectionType == SectionTypeSkills) {
			SkillsReflectionCell *skillsReflectionCell = [self.reflectionTableView dequeueReusableCellWithIdentifier:SkillsReflectionCellIdentifier forIndexPath:indexPath];
			
			[self configureSkillsReflectionCell:skillsReflectionCell forRowAtIndexPath:indexPath];
			
			reflectionCell = skillsReflectionCell;
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
	
	NSInteger reflectionCellIndex = [self reflectionCellIndexForIndexPath:indexPath];
	
	SectionType sectionType = [self sectionTypeForSection:indexPath.section];
	
	if (sectionType == SectionTypeGoals) {
		
	}
	
	else if (sectionType == SectionTypeExperience) {
		NSUInteger numberOfExperienceBackgroundImages = 4;
		
		if (reflectionCellIndex % numberOfExperienceBackgroundImages == 0) {
			imageName = @"App Icon";
		}
		
		else if (reflectionCellIndex % numberOfExperienceBackgroundImages == 1){
			imageName = @"Deep Blue Space";
		}
		
		else if (reflectionCellIndex % numberOfExperienceBackgroundImages == 2) {
			imageName = @"Microprocessor";
		}
		
		else if (reflectionCellIndex % numberOfExperienceBackgroundImages == 3) {
			imageName = @"sky";
		}
	}
	
	else if (sectionType == SectionTypeEducation) {
		NSUInteger numberOfEducationBackgroundImages = 1;
		
		if (reflectionCellIndex % numberOfEducationBackgroundImages == 0) {
			imageName = @"UIUC Union";
		}
	}
	
	else if (sectionType == SectionTypeLeadershipAndActivities) {
		NSUInteger numberOfLeadershipAndActivitiesBackgroundImages = 1;
		
		if (reflectionCellIndex % numberOfLeadershipAndActivitiesBackgroundImages == 0) {
			imageName = @"clownFish";
		}
	}
	
	else if (sectionType == SectionTypeSkills) {
		NSUInteger numberOfSkillsBackgroundImages = 1;
		
		if (reflectionCellIndex % numberOfSkillsBackgroundImages == 0) {
			imageName = @"Solar System";
		}
	}
	
	[cell setReflectionBackgroundViewImage:[UIImage imageNamed:imageName]];
}

- (void)configureExperienceReflectionCell:(ExperienceReflectionCell *)experienceReflectionCell forRowAtIndexPath:(NSIndexPath *)indexPath {
	ReflectionManager *sharedReflectionManager = [ReflectionManager sharedReflectionManager];
	
	ExperienceReflection *experienceReflection = sharedReflectionManager.experienceReflections[[self reflectionCellIndexForIndexPath:indexPath]];
	
	[experienceReflectionCell.employerLabel setText:experienceReflection.employer];
	[experienceReflectionCell.titleLabel setText:experienceReflection.title];
	[experienceReflectionCell.locationLabel setText:experienceReflection.location];
	[experienceReflectionCell.dateLabel setText:experienceReflection.date];
	[experienceReflectionCell.descriptionLabel setText:experienceReflection.description];
}

- (void)configureEducationReflectionCell:(EducationReflectionCell *)educationReflectionCell forRowAtIndexPath:(NSIndexPath *)indexPath {
	ReflectionManager *sharedReflectionManager = [ReflectionManager sharedReflectionManager];
	
	EducationReflection *educationReflection = sharedReflectionManager.educationReflections[[self reflectionCellIndexForIndexPath:indexPath]];
	
	[educationReflectionCell configureDescriptionLabelsForNumberOfDescriptionLabels:educationReflection.descriptions.count];
	[educationReflectionCell.schoolLabel setText:educationReflection.school];
	[educationReflectionCell.majorLabel setText:educationReflection.major];
	[educationReflectionCell.minorLabel setText:educationReflection.minor];
	[educationReflectionCell.expectedGraduationDateLabel setText:educationReflection.expectedGraduationDate];
	[educationReflectionCell.gpaLabel setText:educationReflection.gpa];
	
	NSUInteger index = 0;
	
	for (UILabel *descriptionLabel in educationReflectionCell.descriptionLabels) {
		[descriptionLabel setText:educationReflection.descriptions[index]];
		index++;
	}
}

- (void)configureLeadershipAndActivitiesReflectionCell:(LeadershipAndActivitiesReflectionCell *)leadershipAndActivitiesReflectionCell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
}

- (void)configureSkillsReflectionCell:(SkillsReflectionCell *)skillsReflectionCell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	CGFloat sectionHeaderHeight = 0;
	
	SectionType sectionType = [self sectionTypeForSection:section];
	
	NSString *sectionHeader = [self sectionHeaderForSectionType:sectionType];
	
	CGRect sectionHeaderRect = [self sectionHeaderRectForSectionHeader:sectionHeader];

	sectionHeaderHeight += SECTION_HEADER_VERTICAL_MARGIN;

	sectionHeaderHeight += sectionHeaderRect.size.height;
	
	sectionHeaderHeight += SECTION_HEADER_VERTICAL_MARGIN;
	
	return sectionHeaderHeight;
}

- (NSString *)sectionHeaderForSectionType:(SectionType)sectionType {
	NSString *sectionHeader;
	
	if (sectionType == SectionTypeGoals) {
		sectionHeader = SECTION_HEADER_GOALS_TITLE;
	}
	
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
	
	ReflectionManager *sharedReflectionManager = [ReflectionManager sharedReflectionManager];
	
	if (indexPath.row % 2 == 0) {
		SectionType sectionType = [self sectionTypeForSection:indexPath.section];
		
		if (sectionType == SectionTypeExperience) {
			ExperienceReflection *experienceReflection = sharedReflectionManager.experienceReflections[[self reflectionCellIndexForIndexPath:indexPath]];
			
			ExperienceReflectionCell *prototypicalExperienceReflectionCell = [self.reflectionTableView dequeueReusableCellWithIdentifier:ExperienceReflectionCellIdentifier];
			
			rowHeight = [prototypicalExperienceReflectionCell heightForExperienceReflection:experienceReflection];
		}
		
		else if (sectionType == SectionTypeEducation) {
			EducationReflection *educationReflection = sharedReflectionManager.educationReflections[[self reflectionCellIndexForIndexPath:indexPath]];
			
			EducationReflectionCell *prototypicalEducationReflectionCell = [self.reflectionTableView dequeueReusableCellWithIdentifier:EducationReflectionCellIdentifier];
			
			rowHeight = [prototypicalEducationReflectionCell heightForEducationReflection:educationReflection];
		}
		
		else if (sectionType == SectionTypeLeadershipAndActivities) {
			rowHeight = 120.0f;
		}
		
		else if (sectionType == SectionTypeSkills) {
			rowHeight = 120.0f;
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
	SectionType sectionType = [self sectionTypeForSection:indexPath.section];
	
	NSIndexPath *reflectionCellIndexPath = [NSIndexPath indexPathForRow:indexPath.row/2 inSection:sectionType];
	
	return reflectionCellIndexPath.row;
}

- (SectionType)sectionTypeForSection:(NSInteger)section {
	SectionType sectionType;
	
	if (_selectedMenuItemType == MenuItemTypeAll) {
		sectionType = section;
	}
	
	else if (_selectedMenuItemType == MenuItemTypeGoals) {
		sectionType = SectionTypeGoals;
	}
	
	else if (_selectedMenuItemType == MenuItemTypeExperience) {
		sectionType = SectionTypeExperience;
	}
	
	else if (_selectedMenuItemType == MenuItemTypeEducation) {
		sectionType = SectionTypeEducation;
	}
	
	else if (_selectedMenuItemType == MenuItemTypeLeadershipAndActivities) {
		sectionType = SectionTypeLeadershipAndActivities;
	}
	
	else if (_selectedMenuItemType == MenuItemTypeSkills) {
		sectionType = SectionTypeSkills;
	}
	
	return sectionType;
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
		[menuProfileCell setDelegate:self];
		
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
	CGFloat menuWidth = kScreenWidth - MENU_HORIZONTAL_MARGIN;
	
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

- (void)menu:(Menu *)menu scrollViewDidScroll:(UIScrollView *)scrollView {
	NSArray *visibleCells = [self.menu.menuTableView visibleCells];
	
	CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
	
	MenuProfileCell *menuProfileCell = (MenuProfileCell *)[menu.menuTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:MenuSectionTypeProfile]];
	
    if(y > h) {
		[self.menu.menuTableView.backgroundView setHidden:YES];
		[self.menu.menuTableView setBackgroundColor:[UIColor whiteColor]];
		[menuProfileCell showBackgroundImageView];
    }
	
	else {
		[self.menu.menuTableView.backgroundView setHidden:NO];
		[menuProfileCell hideBackgroundImageView];
	}
	
	for (UITableViewCell *visibleCell in visibleCells) {
		if ([visibleCell isKindOfClass:[MenuProfileCell class]]) {
			MenuProfileCell *menuProfileCell = (MenuProfileCell *)visibleCell;
			
			[menuProfileCell layoutSubviews];
		}
	}
}

- (CGFloat)menuTableView:(UITableView *)menuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat rowHeight = 0;
	
	if (indexPath.section == MenuSectionTypeProfile) {
		MenuProfileCell *prototypicalMenuProfileCell = [menuTableView dequeueReusableCellWithIdentifier:MenuProfileCellReuseIdentifier];
		
		rowHeight = [prototypicalMenuProfileCell height];
	}
	
	else if (indexPath.section == MenuSectionTypeItem) {
		rowHeight = MENU_ITEM_ROW_HEIGHT;
	}
	
	return rowHeight;
}

- (void)menuTableView:(UITableView *)menuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == MenuSectionTypeItem) {
		if (indexPath.row == MenuItemTypeAll) {
			_selectedMenuItemType = MenuItemTypeAll;
		}
		
		else if (indexPath.row == MenuItemTypeGoals) {
			_selectedMenuItemType = MenuItemTypeGoals;
		}
		
		else if (indexPath.row == MenuItemTypeExperience) {
			_selectedMenuItemType = MenuItemTypeExperience;
		}
		
		else if (indexPath.row == MenuItemTypeEducation) {
			_selectedMenuItemType = MenuItemTypeEducation;
		}
		
		else if (indexPath.row == MenuItemTypeLeadershipAndActivities) {
			_selectedMenuItemType = MenuItemTypeLeadershipAndActivities;
		}
		
		else if (indexPath.row == MenuItemTypeSkills) {
			_selectedMenuItemType = MenuItemTypeSkills;
		}
		
		[self.reflectionTableView reloadData];
		[self.menu hide];
	}
}

#pragma mark - Menu profile cell delegate

- (CGPoint)contentOffsetForMenuProfileCell:(MenuProfileCell *)menuProfileCell {
	CGRect menuProfileCellRect = [self.menu.menuTableView rectForRowAtIndexPath:[self.menu.menuTableView indexPathForCell:menuProfileCell]];
	
	CGPoint contentOffset = CGPointMake(menuProfileCellRect.origin.x, self.menu.menuTableView.contentOffset.y);
	
	return contentOffset;
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
	
	[self.menu show];
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
