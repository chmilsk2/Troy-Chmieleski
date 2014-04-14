//
//  SkillButton.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/14/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "SkillButton.h"

#define SKILL_LABEL_HORIZONTAL_MARGIN 14.0f
#define SKILL_LABEL_VERTICAL_MARGIN 7.0f

@implementation SkillButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
	
    if (self) {
		[self addSubview:self.skillLabel];
    }
	
    return self;
}

#pragma mark - Width 

- (CGFloat)widthWithSkillRect:(CGRect)skillRect {
	CGFloat width = skillRect.size.width + 2*SKILL_LABEL_HORIZONTAL_MARGIN;
	
	return width;
}

#pragma mark - Height

- (CGFloat)heightWithSkillRect:(CGRect)skillRect {
	CGFloat height = skillRect.size.height + 2*SKILL_LABEL_VERTICAL_MARGIN;
	
	return height;
}

#pragma mark - Skill label

- (UILabel *)skillLabel {
	if (!_skillLabel) {
		_skillLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	}
	
	return _skillLabel;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	// skill label
	CGRect skillRect = CGRectZero;
	
	if ([self.delegate respondsToSelector:@selector(skillRectForSkillButton:)]) {
		skillRect = [self.delegate skillRectForSkillButton:self];
	}
	
	[self.skillLabel setFrame:CGRectMake(SKILL_LABEL_HORIZONTAL_MARGIN, SKILL_LABEL_VERTICAL_MARGIN, skillRect.size.width, skillRect.size.height)];
}

@end
