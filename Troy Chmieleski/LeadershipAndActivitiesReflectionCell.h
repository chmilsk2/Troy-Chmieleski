//
//  LeadershipAndActivitiesReflectionCell.h
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "ExperienceReflectionCell.h"

@class LeadershipAndActivitiesReflection;

@interface LeadershipAndActivitiesReflectionCell : ExperienceReflectionCell

@property (nonatomic, strong) UILabel *activityLabel;

- (CGFloat)heightForLeadershipAndActivitiesReflection:(LeadershipAndActivitiesReflection *)leadershipAndActivitiesReflection;

@end
