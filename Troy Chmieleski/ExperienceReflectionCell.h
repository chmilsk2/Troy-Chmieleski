//
//  ExperienceReflectionCell.h
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/6/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "ReflectionCell.h"

@class ExperienceReflection;

@interface ExperienceReflectionCell : ReflectionCell

@property (nonatomic, strong) UILabel *employerLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *dateLabel;

- (CGFloat)heightForExperienceReflection:(ExperienceReflection *)experienceReflection;

@end
