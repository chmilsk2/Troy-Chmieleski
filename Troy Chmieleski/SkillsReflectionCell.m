//
//  SkillsReflectionCell.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "SkillsReflectionCell.h"
#import "SkillsReflection.h"
#import "SkillButton.h"

#define SKILL_REFLECTION_CELL_TOP_VERTICAL_MARGIN 30.0f

// skill button
#define SKILL_BUTTON_HORIZONTAL_MARGIN 14.0f
#define SKILL_BUTTON_VERTICAL_MARIGN 14.0f

@interface SkillsReflectionCell () <SkillButtonDelegate>

@end

@implementation SkillsReflectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentSizeDidChange:) name:UIContentSizeCategoryDidChangeNotification object:nil];
	}
	
	return self;
}

#pragma mark - Height

- (CGFloat)heightForSkillsReflection:(SkillsReflection *)skillsReflection {
	CGFloat height = 0;
	
	CGFloat xPos = 0;
	CGFloat yPos = 0;
	
	xPos += SKILL_BUTTON_HORIZONTAL_MARGIN;
	yPos += SKILL_REFLECTION_CELL_TOP_VERTICAL_MARGIN;
	
	NSInteger index = 0;
	
	for (NSString *skill in skillsReflection.skills) {
		SkillButton *prototypicalSkillButton = [self createSkillButton];
		[prototypicalSkillButton.skillLabel setText:skill];
		
		CGRect skillRect = [self skillRectForSkillButton:prototypicalSkillButton];
		CGFloat prototypicalSkillButtonWidth = [prototypicalSkillButton widthWithSkillRect:skillRect];
		CGFloat prototypicalSkillButtonHeight = [prototypicalSkillButton heightWithSkillRect:skillRect];
		
		if (xPos + prototypicalSkillButtonWidth > self.bounds.size.width - SKILL_BUTTON_HORIZONTAL_MARGIN) {
			xPos = SKILL_BUTTON_HORIZONTAL_MARGIN;
			yPos += prototypicalSkillButtonHeight + SKILL_BUTTON_VERTICAL_MARIGN;
		}
		
		if (xPos + prototypicalSkillButtonWidth <= self.bounds.size.width - SKILL_BUTTON_HORIZONTAL_MARGIN) {
			xPos += prototypicalSkillButtonWidth + SKILL_BUTTON_HORIZONTAL_MARGIN;
		}
		
		else {
			xPos = SKILL_BUTTON_HORIZONTAL_MARGIN;
			yPos += prototypicalSkillButtonHeight + SKILL_BUTTON_VERTICAL_MARIGN;
		}
		
		if (index == skillsReflection.skills.count - 1) {
			yPos += prototypicalSkillButtonHeight + SKILL_BUTTON_VERTICAL_MARIGN;
		}
		
		index++;
	}
	
	height = yPos;
	
	return height;
}

#pragma mark - Skill buttons

- (void)configureSkillButtonsWithSkillsCount:(NSInteger)skillsCount {
	if (!_skillButtons) {
		NSMutableArray *skillButtons = [NSMutableArray array];
		
		for (NSInteger i = 0; i < skillsCount; i++) {
			SkillButton *skillButton = [self createSkillButton];
			[self addSubview:skillButton];
			
			[skillButtons addObject:skillButton];
		}
		
		_skillButtons = [skillButtons copy];
	}
}

#pragma mark - Skill button

- (SkillButton *)createSkillButton {
	SkillButton *skillButton = [[SkillButton alloc] initWithFrame:CGRectZero];
	[skillButton setDelegate:self];
	
	[skillButton addTarget:self action:@selector(skillButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
	
	[skillButton.skillLabel setFont:[self skillLabelFont]];
	[skillButton.skillLabel setTextColor:[UIColor whiteColor]];
	
	[skillButton.layer setCornerRadius:6.0f];
	[skillButton.layer setBorderWidth:1.0f];
	[skillButton.layer setBorderColor:[UIColor whiteColor].CGColor];
	
	return skillButton;
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
	for (SkillButton *skillButton in _skillButtons) {
		[skillButton.skillLabel setFont:[self skillLabelFont]];
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	// skill buttons
	CGFloat skillButtonXPos = SKILL_BUTTON_HORIZONTAL_MARGIN;
	CGFloat skillButtonYPos = SKILL_REFLECTION_CELL_TOP_VERTICAL_MARGIN;
	
	for (SkillButton *skillButton in _skillButtons) {
		CGRect skillRect = [self skillRectForSkill:skillButton.skillLabel.text];
		CGFloat skillButtonWidth = [skillButton widthWithSkillRect:skillRect];
		CGFloat skillButtonHeight = [skillButton heightWithSkillRect:skillRect];
		
		if (skillButtonXPos + skillButtonWidth > self.bounds.size.width - SKILL_BUTTON_HORIZONTAL_MARGIN) {
			skillButtonXPos = SKILL_BUTTON_HORIZONTAL_MARGIN;
			skillButtonYPos += skillButtonHeight + SKILL_BUTTON_VERTICAL_MARIGN;
		}
		
		[skillButton setFrame:CGRectMake(skillButtonXPos, skillButtonYPos, skillButtonWidth, skillButtonHeight)];
		
		if (skillButtonXPos + skillButtonWidth <= self.bounds.size.width - SKILL_BUTTON_HORIZONTAL_MARGIN) {
			skillButtonXPos += skillButtonWidth + SKILL_BUTTON_HORIZONTAL_MARGIN;
		}
		
		else {
			skillButtonXPos = SKILL_BUTTON_HORIZONTAL_MARGIN;
			skillButtonYPos += skillButtonHeight + SKILL_BUTTON_VERTICAL_MARIGN;
		}
	}
}

@end
