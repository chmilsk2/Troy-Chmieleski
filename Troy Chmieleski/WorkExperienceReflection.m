//
//  WorkExperienceReflection.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/14/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "WorkExperienceReflection.h"

@implementation WorkExperienceReflection

- (NSString *)employer {
	return self.primary;
}

- (void)setEmployer:(NSString *)employer {
	self.primary = employer;
}

@end
