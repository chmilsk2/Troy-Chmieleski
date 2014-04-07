//
//  ExperienceReflectionCell.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/6/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "ExperienceReflectionCell.h"

#import "ExperienceReflection.h"

// employer label
#define EMPLOYER_LABEL_HORIZONTAL_MARGIN 14.0f
#define EMPLOYER_LABEL_TOP_VERTICAL_MARGIN 30.0f

// title lable
#define TITLE_LABEL_HORIZONTAL_MARGIN 14.0f
#define TITLE_LABEL_TOP_VERTICAL_MARGIN 0.0f

// description label
#define DESCRIPTION_LABEL_VERTICAL_MARGIN 14.0f

@implementation ExperienceReflectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
    if (self) {
		[self addSubview:self.employerLabel];
		[self addSubview:self.titleLabel];
		[self addSubview:self.locationLabel];
		[self addSubview:self.dateLabel];
		[self addSubview:self.descriptionLabel];
    }
	
    return self;
}

#pragma mark - Height

- (CGFloat)heightForExperienceReflection:(ExperienceReflection *)experienceReflection {
	CGFloat height = 0;
	
	height += EMPLOYER_LABEL_TOP_VERTICAL_MARGIN;
	
	CGRect employerRect = [self employerRectForEmployer:experienceReflection.employer];
	height += employerRect.size.height;
	
	height += TITLE_LABEL_TOP_VERTICAL_MARGIN;
	
	CGRect titleRect = [self titleRectForTitle:experienceReflection.title];
	height += titleRect.size.height;
	
	height += DESCRIPTION_LABEL_VERTICAL_MARGIN;
	
	CGRect descriptionRect = [self descriptionRectForDescription:experienceReflection.description];
	height += descriptionRect.size.height;
	
	height += DESCRIPTION_LABEL_VERTICAL_MARGIN;
	
	return height;
}

- (CGRect)employerRectForEmployer:(NSString *)employer {
	CGRect employerRect = CGRectIntegral([employer boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self employerLabelFont]} context:nil]);
	
	return employerRect;
}

- (CGRect)titleRectForTitle:(NSString *)title {
	CGRect titleRect = CGRectIntegral([title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self titleLabelFont]} context:nil]);
	
	return titleRect;
}

- (CGRect)descriptionRectForDescription:(NSString *)description {
	CGRect descriptionRect = CGRectIntegral([description boundingRectWithSize:CGSizeMake(self.bounds.size.width - 2*14.0f, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self descriptionLabelFont]} context:nil]);
	
	return descriptionRect;
}

#pragma mark - Employer label

- (UILabel *)employerLabel {
	if (!_employerLabel) {
		_employerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_employerLabel setFont:[self employerLabelFont]];
		[_employerLabel setTextColor:[UIColor whiteColor]];
	}
	
	return _employerLabel;
}

- (UIFont *)employerLabelFont {
	UIFont *employerLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
	
	return employerLabelFont;
}

#pragma mark - Title label

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_titleLabel setFont:[self titleLabelFont]];
		[_titleLabel setTextColor:[UIColor whiteColor]];
	}
	
	return _titleLabel;
}

- (UIFont *)titleLabelFont {
	UIFont *titleLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
	
	return titleLabelFont;
}

#pragma mark - Description Label

- (UILabel *)descriptionLabel {
	if (!_descriptionLabel) {
		_descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_descriptionLabel setNumberOfLines:0];
		[_descriptionLabel setFont:[self descriptionLabelFont]];
		[_descriptionLabel setTextColor:[UIColor whiteColor]];
	}
	
	return _descriptionLabel;
}

- (UIFont *)descriptionLabelFont {
	UIFont *descriptionLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	
	return descriptionLabelFont;
}

- (void)layoutSubviews {
	// employer label
	CGRect employerRect = [self employerRectForEmployer:self.employerLabel.text];
	
	[self.employerLabel setFrame:CGRectMake(EMPLOYER_LABEL_HORIZONTAL_MARGIN, EMPLOYER_LABEL_TOP_VERTICAL_MARGIN, employerRect.size.width, employerRect.size.height)];
	
	// title label
	CGRect titleRect = [self titleRectForTitle:self.titleLabel.text];
	
	[self.titleLabel setFrame:CGRectMake(TITLE_LABEL_HORIZONTAL_MARGIN, self.employerLabel.frame.origin.y + self.employerLabel.bounds.size.height + TITLE_LABEL_TOP_VERTICAL_MARGIN, titleRect.size.width, titleRect.size.height)];
	
	// description label
	CGRect descriptionRect = [self descriptionRectForDescription:self.descriptionLabel.text];
	
	[self.descriptionLabel setFrame:CGRectMake(14.0f, self.titleLabel.frame.origin.y + self.titleLabel.bounds.size.height + DESCRIPTION_LABEL_VERTICAL_MARGIN, descriptionRect.size.width, descriptionRect.size.height)];
	
	// reflection background view
	[self.reflectionBackgroundView setFrame:self.bounds];
	[self.backgroundTintView setFrame:self.bounds];
	
	UIImage *backgroundImage = [self reflectionBackgroundViewImage];
	
	CGPoint contentOffset;
	
	if ([self.delegate respondsToSelector:@selector(contentOffsetForReflectionCell:)]) {
		contentOffset = [self.delegate contentOffsetForReflectionCell:self];
	}
	
	[self.backgroundImageView setFrame:CGRectMake(contentOffset.x, contentOffset.y, backgroundImage.size.width, backgroundImage.size.height)];
}

@end
