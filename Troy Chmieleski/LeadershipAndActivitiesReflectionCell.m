//
//  LeadershipAndActivitiesReflectionCell.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "LeadershipAndActivitiesReflectionCell.h"
#import "LeadershipAndActivitiesReflection.h"

@implementation LeadershipAndActivitiesReflectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {
		self.activityLabel = self.primaryLabel;
	}
	
	return self;
}

#pragma mark - Height

- (CGFloat)heightForLeadershipAndActivitiesReflection:(LeadershipAndActivitiesReflection *)leadershipAndActivitiesReflection {
	CGFloat height = 0;
	
	height = [self heightForExperienceReflection:leadershipAndActivitiesReflection];
	
	return height;
}

- (void)layoutSubviews {
	[super layoutSubviews];
}

@end
