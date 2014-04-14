//
//  ExperienceReflectionCell.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/6/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "WorkExperienceReflectionCell.h"
#import "WorkExperienceReflection.h"

@implementation WorkExperienceReflectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
    if (self) {
		self.employerLabel = self.primaryLabel;
    }
	
    return self;
}

#pragma mark - Height

- (CGFloat)heightForWorkExperienceReflection:(WorkExperienceReflection *)workExperienceReflection {
	CGFloat height = 0;
	
	height += [self heightForExperienceReflection:workExperienceReflection];
	
	return height;
}

- (void)layoutSubviews {
	[super layoutSubviews];
}

@end
