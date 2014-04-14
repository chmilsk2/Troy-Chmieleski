//
//  SkillsReflectionCell.h
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "ReflectionCell.h"

@class SkillsReflectionCell;
@class SkillsReflection;
@class SkillButton;

@protocol SkillReflectionCellDelegate <NSObject>

- (void)skillReflectionCell:(SkillsReflectionCell *)skillReflectionCell skillButtonTouched:(SkillButton *)skillButton;

@end

@interface SkillsReflectionCell : ReflectionCell

@property (nonatomic, strong) id <SkillReflectionCellDelegate> skillReflectionCellDelegate;
@property (nonatomic, strong) NSArray *skillButtons;

- (CGFloat)heightForSkillsReflection:(SkillsReflection *)skillsReflection;
- (void)configureSkillButtonsWithSkillsCount:(NSInteger)skillsCount;

@end
