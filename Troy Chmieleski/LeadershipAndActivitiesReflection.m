//
//  LeadershipAndActivitiesReflection.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "LeadershipAndActivitiesReflection.h"

@implementation LeadershipAndActivitiesReflection

- (NSString *)activity {
	return self.primary;
}

- (void)setActivity:(NSString *)activity {
	self.primary = activity;
}

@end
