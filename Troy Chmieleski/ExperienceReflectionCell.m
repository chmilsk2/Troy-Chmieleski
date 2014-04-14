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

// title label
#define TITLE_LABEL_HORIZONTAL_MARGIN 14.0f
#define TITLE_LABEL_TOP_VERTICAL_MARGIN 0.0f

// location label
#define LOCATION_LABEL_HORIZONTAL_MARGIN 14.0f
#define LOCATION_LABEL_VERTICAL_MARGIN 14.0f

// date label
#define DATE_LABEL_HORIZONTAL_MARGIN 14.0f
#define DATE_LABEL_TOP_VERTICAL_MARGIN 0.0f

// description label
#define DESCRIPTION_LABEL_HORIZONTAL_MARGIN 14.0f
#define DESCRIPTION_LABEL_TOP_VERTICAL_MARGIN 14.0f

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
	
	// employer label
	height += EMPLOYER_LABEL_TOP_VERTICAL_MARGIN;
	
	CGRect employerRect = [self employerRectForEmployer:experienceReflection.employer];
	height += employerRect.size.height;
	
	// title label
	CGRect titleRect = [self titleRectForTitle:experienceReflection.title];
	
	// date label
	CGRect dateRect = [self dateRectForDate:experienceReflection.date];
	
	if (titleRect.size.height > dateRect.size.height) {
		height += TITLE_LABEL_TOP_VERTICAL_MARGIN;
		height += titleRect.size.height;
	}
	
	else {
		height += DATE_LABEL_TOP_VERTICAL_MARGIN;
		height += dateRect.size.height;
	}
	
	// description label
	height += DESCRIPTION_LABEL_TOP_VERTICAL_MARGIN;
	
	CGRect descriptionRect = [self descriptionRectForDescription:experienceReflection.description];
	height += descriptionRect.size.height;
	
	// location label
	height += LOCATION_LABEL_VERTICAL_MARGIN;
	
	CGRect locationRect = [self locationRectForLocation:experienceReflection.location];
	height += locationRect.size.height;
	
	height += LOCATION_LABEL_VERTICAL_MARGIN;
	
	return height;
}

#pragma mark - Employer label

- (UILabel *)employerLabel {
	if (!_employerLabel) {
		_employerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_employerLabel setNumberOfLines:0];
		[_employerLabel setFont:[self employerLabelFont]];
		[_employerLabel setTextColor:[UIColor whiteColor]];
	}
	
	return _employerLabel;
}


- (CGRect)employerRectForEmployer:(NSString *)employer {
	CGRect employerRect = CGRectIntegral([employer boundingRectWithSize:CGSizeMake(self.bounds.size.width - 2*EMPLOYER_LABEL_HORIZONTAL_MARGIN, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self employerLabelFont]} context:nil]);
	
	return employerRect;
}

- (UIFont *)employerLabelFont {
	UIFont *employerLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
	
	return employerLabelFont;
}

#pragma mark - Title label

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_titleLabel setNumberOfLines:0];
		[_titleLabel setFont:[self titleLabelFont]];
		[_titleLabel setTextColor:[UIColor whiteColor]];
	}
	
	return _titleLabel;
}

- (CGRect)titleRectForTitle:(NSString *)title {
	CGRect titleRect = CGRectIntegral([title boundingRectWithSize:CGSizeMake(self.bounds.size.width/2 - 2*TITLE_LABEL_HORIZONTAL_MARGIN, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self titleLabelFont]} context:nil]);
	
	return titleRect;
}

- (UIFont *)titleLabelFont {
	UIFont *titleLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
	
	return titleLabelFont;
}

#pragma mark - Location label

- (UILabel *)locationLabel {
	if (!_locationLabel) {
		_locationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_locationLabel setNumberOfLines:0];
		[_locationLabel setFont:[self locationLabelFont]];
		[_locationLabel setTextColor:[UIColor whiteColor]];
	}
	
	return _locationLabel;
}

- (CGRect)locationRectForLocation:(NSString *)location {
	CGRect locationRect = CGRectIntegral([location boundingRectWithSize:CGSizeMake(self.bounds.size.width - 2*LOCATION_LABEL_HORIZONTAL_MARGIN, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self locationLabelFont]} context:nil]);
	
	return locationRect;
}

- (UIFont *)locationLabelFont {
	UIFont *locationLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
	
	return locationLabelFont;
}

#pragma mark - Date label

- (UILabel *)dateLabel {
	if (!_dateLabel) {
		_dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_dateLabel setNumberOfLines:0];
		[_dateLabel setFont:[self dateLabelFont]];
		[_dateLabel setTextColor:[UIColor whiteColor]];
	}
	
	return _dateLabel;
}

- (CGRect)dateRectForDate:(NSString *)date {
	CGRect dateRect = CGRectIntegral([date boundingRectWithSize:CGSizeMake(self.bounds.size.width/2 - 2*DATE_LABEL_HORIZONTAL_MARGIN, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self dateLabelFont]} context:nil]);
	
	return dateRect;
}

- (UIFont *)dateLabelFont {
	UIFont *dateLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
	
	return dateLabelFont;
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

- (CGRect)descriptionRectForDescription:(NSString *)description {
	CGRect descriptionRect = CGRectIntegral([description boundingRectWithSize:CGSizeMake(self.bounds.size.width - 2*DESCRIPTION_LABEL_HORIZONTAL_MARGIN, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self descriptionLabelFont]} context:nil]);
	
	return descriptionRect;
}

- (UIFont *)descriptionLabelFont {
	UIFont *descriptionLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	
	return descriptionLabelFont;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	// employer label
	CGRect employerRect = [self employerRectForEmployer:self.employerLabel.text];
	
	[self.employerLabel setFrame:CGRectMake(EMPLOYER_LABEL_HORIZONTAL_MARGIN, EMPLOYER_LABEL_TOP_VERTICAL_MARGIN, employerRect.size.width, employerRect.size.height)];
	
	// title label
	CGRect titleRect = [self titleRectForTitle:self.titleLabel.text];
	
	[self.titleLabel setFrame:CGRectMake(TITLE_LABEL_HORIZONTAL_MARGIN, self.employerLabel.frame.origin.y + self.employerLabel.bounds.size.height + TITLE_LABEL_TOP_VERTICAL_MARGIN, titleRect.size.width, titleRect.size.height)];
	
	// date label
	CGRect dateRect = [self dateRectForDate:self.dateLabel.text];
	
	[self.dateLabel setFrame:CGRectMake(self.bounds.size.width - (dateRect.size.width + DATE_LABEL_HORIZONTAL_MARGIN), self.titleLabel.frame.origin.y +DATE_LABEL_TOP_VERTICAL_MARGIN, dateRect.size.width, dateRect.size.height)];
	
	// description label
	CGRect descriptionRect = [self descriptionRectForDescription:self.descriptionLabel.text];
	
	CGFloat descriptionLabelYPos = DESCRIPTION_LABEL_TOP_VERTICAL_MARGIN;
	
	if (titleRect.size.height > dateRect.size.height) {
		descriptionLabelYPos += self.titleLabel.frame.origin.y + self.titleLabel.bounds.size.height;
	}
	
	else {
		descriptionLabelYPos += self.dateLabel.frame.origin.y + self.dateLabel.bounds.size.height;
	}
	
	[self.descriptionLabel setFrame:CGRectMake(DESCRIPTION_LABEL_HORIZONTAL_MARGIN, descriptionLabelYPos, descriptionRect.size.width, descriptionRect.size.height)];
	
	// location label
	CGRect locationRect = [self locationRectForLocation:self.locationLabel.text];
	
	[self.locationLabel setFrame:CGRectMake((self.bounds.size.width - locationRect.size.width)/2, self.descriptionLabel.frame.origin.y + self.descriptionLabel.bounds.size.height + LOCATION_LABEL_VERTICAL_MARGIN, locationRect.size.width, locationRect.size.height)];
}

@end
