//
//  ReflectionManager.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "ReflectionManager.h"
#import "ExperienceReflection.h"
#import "EducationReflection.h"

@implementation ReflectionManager

+ (instancetype)sharedReflectionManager {
	static ReflectionManager *sharedReflectionManager;
	
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		sharedReflectionManager = [[ReflectionManager alloc] init];
	});
	
	return sharedReflectionManager;
}

- (id)init {
    self = [super init];
	
    if (self) {
		[self setUpGoalsReflections];
		[self setUpExperienceReflections];
		[self setUpEducationReflections];
		[self setUpLeadershipAndActivitiesReflections];
		[self setUpSkillsReflections];
    }
	
    return self;
}

- (void)setUpGoalsReflections {
	_goalsReflections = [[NSMutableArray alloc] init];
}

- (void)setUpExperienceReflections {
	_experienceReflections = [[NSMutableArray alloc] init];
	
	ExperienceReflection *iOSInternExperienceReflection = [[ExperienceReflection alloc] init];
	[iOSInternExperienceReflection setEmployer:@"DONEBOX"];
	[iOSInternExperienceReflection setTitle:@"iOS Intern"];
	[iOSInternExperienceReflection setDescription:@"Developing an app that links together email, contacts, calendars and todos"];
	[iOSInternExperienceReflection setLocation:@"Cambridge, MA"];
	[iOSInternExperienceReflection setDate:@"Jun '13 \u2013 Present"];
	
	ExperienceReflection *uiucTinnitusLabIOSDeveloperExperienceReflection = [[ExperienceReflection alloc] init];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setEmployer:@"UIUC TINNITUS LAB"];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setTitle:@"iOS Developer"];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setDescription:@"Designing fractal tone therapy for Tinnitus that leverages the power of Core Audio"];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setLocation:@"Urbana, IL"];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setDate:@"Apr '13 \u2013 Present"];
	
	ExperienceReflection *citesOnsiteConsultantExperienceReflection = [[ExperienceReflection alloc] init];
	[citesOnsiteConsultantExperienceReflection setEmployer:@"CITES ONSITE CONSULTING"];
	[citesOnsiteConsultantExperienceReflection setTitle:@"Consultant"];
	[citesOnsiteConsultantExperienceReflection setDescription:@"Facilitated on-site computer consulting services in both home and enterprise environments"];
	[citesOnsiteConsultantExperienceReflection setLocation:@"Urbana, IL"];
	[citesOnsiteConsultantExperienceReflection setDate:@"Sep '12 \u2013 May '13"];
	
	ExperienceReflection *universityRelationsOfficeAssistantExperienceReflection = [[ExperienceReflection alloc] init];
	[universityRelationsOfficeAssistantExperienceReflection setEmployer:@"UNIVERSITY RELATIONS"];
	[universityRelationsOfficeAssistantExperienceReflection setTitle:@"Office Assistant"];
	[universityRelationsOfficeAssistantExperienceReflection setDescription:@"Updated official records and PrezRelease, the blog of the University of Illinois president"];
	[universityRelationsOfficeAssistantExperienceReflection setLocation:@"Urbana, IL"];
	[universityRelationsOfficeAssistantExperienceReflection setDate:@"Feb '12 \u2013 May '12"];
	
	[_experienceReflections addObjectsFromArray:@[iOSInternExperienceReflection, uiucTinnitusLabIOSDeveloperExperienceReflection, citesOnsiteConsultantExperienceReflection, universityRelationsOfficeAssistantExperienceReflection]];
}

- (void)setUpEducationReflections {
	_educationReflections = [NSMutableArray array];
	
	EducationReflection *universityReflection = [[EducationReflection alloc] init];
	[universityReflection setSchool:@"UIUC"];
	[universityReflection setMajor:@"B.S. in E.E."];
	[universityReflection setMinor:@"Minor in C.S."];
	[universityReflection setExpectedGraduationDate:@"May '15"];
	[universityReflection setGpa:@"GPA: 3.65/4.00"];
	
	[_educationReflections addObjectsFromArray:@[universityReflection]];
}

- (void)setUpLeadershipAndActivitiesReflections {
	_leadershipAndActivitiesReflections = [[NSMutableArray alloc] init];
	
	[_leadershipAndActivitiesReflections addObject:[NSNull null]];
}

- (void)setUpSkillsReflections {
	_skillsReflections = [[NSMutableArray alloc] init];
	
	[_skillsReflections addObject:[NSNull null]];
}

@end
