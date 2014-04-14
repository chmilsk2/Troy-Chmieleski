//
//  WorkExperienceReflectionCell.h
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/6/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "ExperienceReflectionCell.h"

@class WorkExperienceReflection;

@interface WorkExperienceReflectionCell : ExperienceReflectionCell

@property (nonatomic, strong) UILabel *employerLabel;

- (CGFloat)heightForWorkExperienceReflection:(WorkExperienceReflection *)workExperienceReflection;

@end
