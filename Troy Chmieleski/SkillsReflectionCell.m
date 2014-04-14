//
//  SkillsReflectionCell.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "SkillsReflectionCell.h"
#import "SkillButton.h"

// skill button
#define SKILL @"Objective-C"
#define SKILL_BUTTON_HORIZONTAL_MARGIN 14.0f
#define SKILL_BUTTON_VERTICAL_MARGIN 30.0f

@interface SkillsReflectionCell () <SkillButtonDelegate>

@end

@implementation SkillsReflectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {
		[self addSubview:self.skillButton];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentSizeDidChange:) name:UIContentSizeCategoryDidChangeNotification object:nil];
	}
	
	return self;
}

#pragma mark - Skill button

- (SkillButton *)skillButton {
	if (!_skillButton) {
		_skillButton = [[SkillButton alloc] initWithFrame:CGRectZero];
		[_skillButton setDelegate:self];
		
		[_skillButton addTarget:self action:@selector(skillButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
		
		[_skillButton.skillLabel setFont:[self skillLabelFont]];
		[_skillButton.skillLabel setTextColor:[UIColor whiteColor]];
		[_skillButton.skillLabel setText:SKILL];
		
		[_skillButton.layer setCornerRadius:6.0f];
		[_skillButton.layer setBorderWidth:1.0f];
		[_skillButton.layer setBorderColor:[UIColor whiteColor].CGColor];
	}
	
	return _skillButton;
}

- (void)skillButtonTouched:(id)sender {
	SkillButton *skillButton = (SkillButton *)sender;
	
	if ([self.skillReflectionCellDelegate respondsToSelector:@selector(skillReflectionCell:skillButtonTouched:)]) {
		[self.skillReflectionCellDelegate skillReflectionCell:self skillButtonTouched:skillButton];
	}
}

- (CGRect)skillRectForSkillButton:(SkillButton *)skillButton {
	CGRect skillRect = [self skillRectForSkill:skillButton.skillLabel.text];
	
	return skillRect;
}

- (CGRect)skillRectForSkill:(NSString *)skill {
	CGRect skillRect = CGRectIntegral([skill boundingRectWithSize:CGSizeMake(self.bounds.size.width - 2*SKILL_BUTTON_HORIZONTAL_MARGIN, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self skillLabelFont]} context:nil]);
	
	return skillRect;
}

- (UIFont *)skillLabelFont {
	UIFont *skillLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	
	return skillLabelFont;
}

#pragma mark - Content size did change notification

- (void)contentSizeDidChange:(NSNotification *)notification {
	[self.skillButton.skillLabel setFont:[self skillLabelFont]];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	// skill button
	CGRect skillRect = [self skillRectForSkill:self.skillButton.skillLabel.text];
	CGFloat skillButtonWidth = [self.skillButton widthWithSkillRect:skillRect];
	CGFloat skillButtonHeight = [self.skillButton heightWithSkillRect:skillRect];
	
	[self.skillButton setFrame:CGRectMake(SKILL_BUTTON_HORIZONTAL_MARGIN, SKILL_BUTTON_VERTICAL_MARGIN, skillButtonWidth, skillButtonHeight)];
}

@end
