//
//  EducationReflectionCell.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/7/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "EducationReflectionCell.h"
#import "EducationReflection.h"

// school label
#define SCHOOL_LABEL_HORIZONTAL_MARGIN 14.0f
#define SCHOOL_LABEL_TOP_VERTICAL_MARGIN 30.0f

// major label
#define MAJOR_LABEL_HORIZONTAL_MARGIN 14.0f
#define MAJOR_LABEL_TOP_VERTICAL_MARGIN 0.0f

// minor label
#define MINOR_LABEL_HORIZONTAL_MARGIN 14.0f
#define MINOR_LABEL_TOP_VERTICAL_MARGIN 0.0f

// expected graduation date label
#define EXPECTED_GRADUATION_DATE_LABEL_HORIZONTAL_MARGIN 14.0f
#define EXPECTED_GRADUATION_DATE_LABEL_VERTICAL_MARGIN 0.0f

// gpa label
#define GPA_LABEL_HORIZONTAL_MARGIN 14.0f
#define GPA_LABEL_TOP_VERTICAL_MARGIN 0.0f

// bullet label
#define BULLET_LABEL_TEXT @"\u2022"

// description label
#define DESCRIPTION_LABEL_HORIZONTAL_MARGIN 14.0f
#define DESCRIPTION_LABELS_VERTICAL_MARGIN 14.0f

@interface EducationReflectionCell ()

@property (nonatomic, strong) NSArray *descriptionBulletLabels;

@end

@implementation EducationReflectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {
		[self addSubview:self.schoolLabel];
		[self addSubview:self.majorLabel];
		[self addSubview:self.minorLabel];
		[self addSubview:self.expectedGraduationDateLabel];
		[self addSubview:self.gpaLabel];
	}
	
	return self;
}

#pragma mark - Height

- (CGFloat)heightForEducationReflection:(EducationReflection *)educationReflection {
	CGFloat height = 0;
	
	// school label
	height += SCHOOL_LABEL_TOP_VERTICAL_MARGIN;
	
	CGRect schoolRect = [self schoolRectForSchool:educationReflection.school];
	height += schoolRect.size.height;
	
	// major label
	CGRect majorRect = [self majorRectForMajor:educationReflection.major];
	
	// minor label
	CGRect minorRect = [self minorRectForMinor:educationReflection.minor];
	
	// expected graduation date label
	CGRect expectedGraduationDateRect = [self expectedGraduationDateRectForExpectedGraduationDate:educationReflection.expectedGraduationDate];
	
	// gpa label
	CGRect gpaRect = [self gpaRectForGpa:educationReflection.gpa];
	
	if (majorRect.size.height > expectedGraduationDateRect.size.height) {
		height += majorRect.size.height;
		height += MAJOR_LABEL_TOP_VERTICAL_MARGIN;
	}
	
	else {
		height += EXPECTED_GRADUATION_DATE_LABEL_VERTICAL_MARGIN;
		height += expectedGraduationDateRect.size.height;
	}
	
	if (minorRect.size.height > gpaRect.size.height) {
		height += MINOR_LABEL_TOP_VERTICAL_MARGIN;
		height += minorRect.size.height;
	}
	
	else {
		height += GPA_LABEL_TOP_VERTICAL_MARGIN;
		height += gpaRect.size.height;
	}
	
	// bullet/description labels
	height += DESCRIPTION_LABELS_VERTICAL_MARGIN;
	
	for (NSString *description in educationReflection.descriptions) {
		CGRect descriptionRect = [self descriptionRectForDescription:description];
		height += descriptionRect.size.height;
	}
	
	if (educationReflection.descriptions.count > 0) {
		height += DESCRIPTION_LABELS_VERTICAL_MARGIN;
	}
	
	return height;
}

#pragma mark - School label

- (UILabel *)schoolLabel {
	if (!_schoolLabel) {
		_schoolLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_schoolLabel setNumberOfLines:0];
		[_schoolLabel setFont:[self schoolLabelFont]];
		[_schoolLabel setTextColor:[UIColor whiteColor]];
	}
	
	return _schoolLabel;
}

- (CGRect)schoolRectForSchool:(NSString *)school {
	CGRect schoolRect = CGRectIntegral([school boundingRectWithSize:CGSizeMake(self.bounds.size.width/2 - 2*SCHOOL_LABEL_HORIZONTAL_MARGIN, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self schoolLabelFont]} context:nil]);
	
	return schoolRect;
}

- (UIFont *)schoolLabelFont {
	UIFont *schoolLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
	
	return schoolLabelFont;
}

#pragma mark - Major Label

- (UILabel *)majorLabel {
	if (!_majorLabel) {
		_majorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_majorLabel setNumberOfLines:0];
		[_majorLabel setFont:[self majorLabelFont]];
		[_majorLabel setTextColor:[UIColor whiteColor]];
	}
	
	return _majorLabel;
}

- (CGRect)majorRectForMajor:(NSString *)major {
	CGRect majorRect = CGRectIntegral([major boundingRectWithSize:CGSizeMake(self.bounds.size.width/2 - 2*MAJOR_LABEL_HORIZONTAL_MARGIN, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self majorLabelFont]} context:nil]);
	
	return majorRect;
}

- (UIFont *)majorLabelFont {
	UIFont *majorLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
	
	return majorLabelFont;
}

#pragma mark - Minor Label

- (UILabel *)minorLabel {
	if (!_minorLabel) {
		_minorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_minorLabel setNumberOfLines:0];
		[_minorLabel setFont:[self minorLabelFont]];
		[_minorLabel setTextColor:[UIColor whiteColor]];
	}
	
	return _minorLabel;
}

- (CGRect)minorRectForMinor:(NSString *)minor {
	CGRect minorRect = CGRectIntegral([minor boundingRectWithSize:CGSizeMake(self.bounds.size.width/2 - 2*MINOR_LABEL_HORIZONTAL_MARGIN, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self minorLabelFont]} context:nil]);
	
	return minorRect;
}

- (UIFont *)minorLabelFont {
	UIFont *minorLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
	
	return minorLabelFont;
}

#pragma mark - Expected graduation date label

- (UILabel *)expectedGraduationDateLabel {
	if (!_expectedGraduationDateLabel) {
		_expectedGraduationDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_expectedGraduationDateLabel setFont:[self expectedGraduationDateLabelFont]];
		[_expectedGraduationDateLabel setTextColor:[UIColor whiteColor]];
	}
	
	return _expectedGraduationDateLabel;
}

- (CGRect)expectedGraduationDateRectForExpectedGraduationDate:(NSString *)expectedGraduationDate {
	CGRect expectedGraduationDateRect = CGRectIntegral([expectedGraduationDate boundingRectWithSize:CGSizeMake(self.bounds.size.width/2 - 2*EXPECTED_GRADUATION_DATE_LABEL_HORIZONTAL_MARGIN, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self expectedGraduationDateLabelFont]} context:nil]);
	
	return expectedGraduationDateRect;
}

- (UIFont *)expectedGraduationDateLabelFont {
	UIFont *expectedGraduationDateLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
	
	return expectedGraduationDateLabelFont;
}

#pragma mark - Gpa label

- (UILabel *)gpaLabel {
	if (!_gpaLabel) {
		_gpaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_gpaLabel setFont:[self gpaLabelFont]];
		[_gpaLabel setTextColor:[UIColor whiteColor]];
	}
	
	return _gpaLabel;
}

- (CGRect)gpaRectForGpa:(NSString *)gpa {
	CGRect gpaRect = CGRectIntegral([gpa boundingRectWithSize:CGSizeMake(self.bounds.size.width/2 - 2*GPA_LABEL_HORIZONTAL_MARGIN, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self gpaLabelFont]} context:nil]);
	
	return gpaRect;
}

- (UIFont *)gpaLabelFont {
	UIFont *gpaLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
	
	return gpaLabelFont;
}

#pragma mark - Description/Bullet labels

- (void)configureDescriptionLabelsForNumberOfDescriptionLabels:(NSInteger)numberOfDescriptionLabels {
	if (!_descriptionLabels || !_descriptionBulletLabels) {
		NSMutableArray *descriptionBulletLabels = [NSMutableArray array];
		NSMutableArray *descriptionLabels = [NSMutableArray array];
		
		for (NSInteger i = 0; i < numberOfDescriptionLabels; i++) {
			UILabel *bulletLabel = [self createBulletLabel];
			[descriptionBulletLabels addObject:bulletLabel];
			
			UILabel *descriptionLabel = [self createDescriptionLabel];
			[descriptionLabels addObject:descriptionLabel];
			
			[self addSubview:bulletLabel];
			[self addSubview:descriptionLabel];
		}
		
		_descriptionBulletLabels = [descriptionBulletLabels copy];
		_descriptionLabels = [descriptionLabels copy];
	}
}

#pragma mark - Bullet label

- (UILabel *)createBulletLabel {
	UILabel *bulletLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	[bulletLabel setText:@"\u2022"];
	[bulletLabel setTextColor:[UIColor whiteColor]];
	[bulletLabel setFont:[self descriptionLabelFont]];
	
	return bulletLabel;
}

- (CGRect)bulletLabelRect {
	CGRect bulletLabelRect = CGRectIntegral([BULLET_LABEL_TEXT boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self bulletLabelFont]} context:nil]);
	
	return bulletLabelRect;
}

- (UIFont *)bulletLabelFont {
	UIFont *bulletLabelFont = [self descriptionLabelFont];
	
	return bulletLabelFont;
}

#pragma mark - Description Label

- (UILabel *)createDescriptionLabel {
	UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	[descriptionLabel setNumberOfLines:0];
	[descriptionLabel setFont:[self descriptionLabelFont]];
	[descriptionLabel setTextColor:[UIColor whiteColor]];
	
	return descriptionLabel;
}

- (CGRect)descriptionRectForDescription:(NSString *)description {
	CGRect bulletRect = [self bulletLabelRect];
	
	CGRect descriptionRect = CGRectIntegral([description boundingRectWithSize:CGSizeMake(self.bounds.size.width - (bulletRect.size.width + 14.0f + 2*DESCRIPTION_LABEL_HORIZONTAL_MARGIN), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self descriptionLabelFont]} context:nil]);
	
	return descriptionRect;
}


- (UIFont *)descriptionLabelFont {
	UIFont *descriptionLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	
	return descriptionLabelFont;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	// school label
	CGRect schoolRect = [self schoolRectForSchool:self.schoolLabel.text];
	
	[self.schoolLabel setFrame:CGRectMake(SCHOOL_LABEL_HORIZONTAL_MARGIN, SCHOOL_LABEL_TOP_VERTICAL_MARGIN, schoolRect.size.width, schoolRect.size.height)];
	
	// major label
	CGRect majorRect = [self majorRectForMajor:self.majorLabel.text];
	
	[self.majorLabel setFrame:CGRectMake(MAJOR_LABEL_HORIZONTAL_MARGIN, self.schoolLabel.frame.origin.y + self.schoolLabel.bounds.size.height + MAJOR_LABEL_TOP_VERTICAL_MARGIN, majorRect.size.width, majorRect.size.height)];
	
	// minor label
	CGRect minorRect = [self minorRectForMinor:self.minorLabel.text];
	
	[self.minorLabel setFrame:CGRectMake(MINOR_LABEL_HORIZONTAL_MARGIN, self.majorLabel.frame.origin.y + self.majorLabel.bounds.size.height + MINOR_LABEL_TOP_VERTICAL_MARGIN, minorRect.size.width, minorRect.size.height)];
	
	// expected graduation date label
	CGRect expectedGraduationDateRect = [self expectedGraduationDateRectForExpectedGraduationDate:self.expectedGraduationDateLabel.text];
	
	[self.expectedGraduationDateLabel setFrame:CGRectMake(self.bounds.size.width - (expectedGraduationDateRect.size.width + EXPECTED_GRADUATION_DATE_LABEL_HORIZONTAL_MARGIN), self.majorLabel.frame.origin.y, expectedGraduationDateRect.size.width, expectedGraduationDateRect.size.height)];
	
	// gpa label
	CGRect gpaRect = [self gpaRectForGpa:self.gpaLabel.text];
	
	[self.gpaLabel setFrame:CGRectMake(self.bounds.size.width - (gpaRect.size.width + GPA_LABEL_HORIZONTAL_MARGIN), self.expectedGraduationDateLabel.frame.origin.y + self.expectedGraduationDateLabel.bounds.size.height + GPA_LABEL_TOP_VERTICAL_MARGIN, gpaRect.size.width, gpaRect.size.height)];
	
	// bullet/descriptions labels
	CGFloat bulletLabelYPos = self.minorLabel.frame.origin.y + self.minorLabel.bounds.size.height + DESCRIPTION_LABELS_VERTICAL_MARGIN;
	
	NSUInteger index = 0;
	
	for (UILabel *bulletLabel in _descriptionBulletLabels) {
		UILabel *descriptionLabel = _descriptionLabels[index];
		
		CGRect bulletRect = [self bulletLabelRect];
		CGRect descriptionRect = [self descriptionRectForDescription:descriptionLabel.text];
		CGRect previousDescriptionRect = CGRectZero;
		
		if (index > 0) {
			UILabel *previousDescriptionLabel = _descriptionLabels[index - 1];
			NSString *previousDescription = previousDescriptionLabel.text;
			previousDescriptionRect = [self descriptionRectForDescription:previousDescription];
			bulletLabelYPos += previousDescriptionRect.size.height;
		}
		
		[bulletLabel setFrame:CGRectMake(DESCRIPTION_LABEL_HORIZONTAL_MARGIN, bulletLabelYPos, bulletRect.size.width, bulletRect.size.height)];
		[descriptionLabel setFrame:CGRectMake(bulletLabel.frame.origin.x + bulletLabel.bounds.size.width + DESCRIPTION_LABEL_HORIZONTAL_MARGIN, bulletLabelYPos, descriptionRect.size.width, descriptionRect.size.height)];
		
		index++;
	}
}

@end
