//
//  ReflectionViewController.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/6/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "ReflectionViewController.h"

// Experience reflection
#import "ExperienceReflection.h"

// Experience reflection cell
#import "ExperienceReflectionCell.h"

// Google Analytics
#define SCREEN_NAME @"Reflection Screen"

#define ExperienceReflectionCellIdentifier @"Experience Reflection Cell Identifier"
#define ReflectionPaddingCellIdentifier @"Reflection Padding Cell Identifier"
#define NUMBER_OF_SECTIONS 1
#define REFLECTION_CELL_PADDING_ROW_HEIGHT 6.0f

// Screen dimensions
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// Status bar height
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

@interface ReflectionViewController () <ReflectionCelDelegate>

@property (nonatomic, strong) NSMutableArray *reflections;

@end

@implementation ReflectionViewController

- (id)init {
    self = [super init];
	
    if (self) {
		// Google Analytics
        [self setScreenName:SCREEN_NAME];
		
		_reflections = [[NSMutableArray alloc] init];
		
		ExperienceReflection *iOSInternExperienceReflection = [[ExperienceReflection alloc] init];
		
		[iOSInternExperienceReflection setEmployer:@"DONEBOX"];
		[iOSInternExperienceReflection setTitle:@"iOS INTERN"];
		[iOSInternExperienceReflection setDescription:@"Developing an app that links together email, calendars and todos"];
		[iOSInternExperienceReflection setLocation:@"Cambridge, MA"];
		[iOSInternExperienceReflection setDate:@"June 2013 --- Present"];
		
		[_reflections addObjectsFromArray:@[iOSInternExperienceReflection]];
		
		[self setUpReflectionTableView];
		
		[self.view addSubview:self.reflectionTableView];
		
		
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
	[self.reflectionTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReflectionPaddingCellIdentifier];
	[self.reflectionTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    return 2*_reflections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;
	
	if (indexPath.row % 2 == 0) {
		ReflectionCell *reflectionCell;
		
		Reflection *reflection = _reflections[indexPath.row/2];
		
		if ([reflection isKindOfClass:[ExperienceReflection class]]) {
			ExperienceReflectionCell *experienceReflectionCell = [self.reflectionTableView dequeueReusableCellWithIdentifier:ExperienceReflectionCellIdentifier forIndexPath:indexPath];
			
			[self configureExperienceReflectionCell:experienceReflectionCell forRowAtIndexPath:indexPath];
			
			reflectionCell = experienceReflectionCell;
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
	
	if (indexPath.row/2 % 5 == 0) {
		imageName = @"rainbowApple";
	}
	
	else if (indexPath.row/2 % 5 == 1){
		imageName = @"bmw";
	}
	
	else if (indexPath.row/2 % 5 == 2) {
		imageName = @"clownFish";
	}
	
	else if (indexPath.row/2 % 5 == 3) {
		imageName = @"quotes";
	}
	
	else if (indexPath.row/2 % 5 == 4) {
		imageName = @"sky";
	}
	
	[cell setReflectionBackgroundViewImage:[UIImage imageNamed:imageName]];
}

- (void)configureExperienceReflectionCell:(ExperienceReflectionCell *)experienceReflectionCell forRowAtIndexPath:(NSIndexPath *)indexPath {
	ExperienceReflection *experienceReflection = _reflections[indexPath.row];
	
	[experienceReflectionCell.employerLabel setText:experienceReflection.employer];
	[experienceReflectionCell.titleLabel setText:experienceReflection.title];
	[experienceReflectionCell.locationLabel setText:experienceReflection.location];
	[experienceReflectionCell.dateLabel setText:experienceReflection.date];
	[experienceReflectionCell.descriptionLabel setText:experienceReflection.description];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat rowHeight = 0;
	
	if (indexPath.row % 2 == 0) {
		Reflection *reflection = _reflections[indexPath.row/2];
		
		if ([reflection isKindOfClass:[ExperienceReflection class]]) {
			ExperienceReflection *experienceReflection = (ExperienceReflection *)reflection;
			
			ExperienceReflectionCell *prototypicalExperienceReflectionCell = [self.reflectionTableView dequeueReusableCellWithIdentifier:ExperienceReflectionCellIdentifier];
			
			rowHeight = [prototypicalExperienceReflectionCell heightForExperienceReflection:experienceReflection];
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

#pragma mark - Reflection table view

- (UITableView *)reflectionTableView {
	if (!_reflectionTableView) {
		_reflectionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kScreenHeight - kStatusBarHeight) style:UITableViewStylePlain];
		[_reflectionTableView setDataSource:self];
		[_reflectionTableView setDelegate:self];
	}
	
	return _reflectionTableView;
}

#pragma mark - Content size did change notification

- (void)contentSizeDidChange:(NSNotification *)notification {
	[self.reflectionTableView reloadRowsAtIndexPaths:[self.reflectionTableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
