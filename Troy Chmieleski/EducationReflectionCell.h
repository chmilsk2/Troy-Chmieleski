//
//  EducationReflectionCell.h
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/7/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "ReflectionCell.h"

@class EducationReflection;

@interface EducationReflectionCell : ReflectionCell

@property (nonatomic, strong) UILabel *schoolLabel;
@property (nonatomic, strong) UILabel *majorLabel;
@property (nonatomic, strong) UILabel *minorLabel;
@property (nonatomic, strong) UILabel *expectedGraduationDateLabel;
@property (nonatomic, strong) UILabel *gpaLabel;
@property (nonatomic, strong) NSArray *descriptionLabels;

- (CGFloat)heightForEducationReflection:(EducationReflection *)educationReflection;
- (void)configureDescriptionLabelsForNumberOfDescriptionLabels:(NSInteger)numberOfDescriptionLabels;

@end
