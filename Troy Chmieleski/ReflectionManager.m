//
//  ReflectionManager.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "ReflectionManager.h"
#import "WorkExperienceReflection.h"
#import "EducationReflection.h"
#import "LeadershipAndActivitiesReflection.h"
#import "SkillsReflection.h"

// Skills
#define SKILL_C @"C"
#define SKILL_OBJECTIVE_C @"Objective-C"
#define SKILL_C_PLUS_PLUS @"C++"
#define SKILL_NODE_JS @"Node.js"
#define SKILL_JAVASCRIPT @"JavaScript"
#define SKILL_SQL @"SQL"
#define SKILL_AWS @"AWS"
#define SKILL_HTML @"HTML"
#define SKILL_CSS @"CSS"
#define SKILL_PYTHON @"Python"
#define SKILL_GIT @"Git"
#define SKILL_LATEX @"LaTeX"
#define SKILL_ASSEMBLY @"Assembly"
#define SKILL_COMPUTER_ARCHITECTURE @"Computer Architecture"
#define SKILL_CIRCUIT_DESIGN @"Circuit Design"
#define SKILL_DIGITAL_SIGNAL_PROCESSING @"Digital Signal Processing"
#define SKILL_SOLDERING @"Soldering"

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
		[self setUpWorkExperienceReflections];
		[self setUpEducationReflections];
		[self setUpLeadershipAndActivitiesReflections];
		[self setUpSkillsReflections];
		[self setUpSkillsWikipediaDict];
    }
	
    return self;
}

- (void)setUpWorkExperienceReflections {
	_workExperienceReflections = [[NSMutableArray alloc] init];
	
	WorkExperienceReflection *iOSInternExperienceReflection = [[WorkExperienceReflection alloc] init];
	[iOSInternExperienceReflection setEmployer:@"DONEBOX"];
	[iOSInternExperienceReflection setTitle:@"iOS Intern"];
	[iOSInternExperienceReflection setDescription:@"Developing an app that links together email, contacts, calendars and todos"];
	[iOSInternExperienceReflection setLocation:@"Cambridge, MA"];
	[iOSInternExperienceReflection setDate:@"Jun '13 \u2013 Present"];
	
	WorkExperienceReflection *uiucTinnitusLabIOSDeveloperExperienceReflection = [[WorkExperienceReflection alloc] init];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setEmployer:@"UIUC TINNITUS LAB"];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setTitle:@"iOS Developer"];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setDescription:@"Designing fractal tone therapy for Tinnitus that leverages the power of Core Audio"];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setLocation:@"Urbana, IL"];
	[uiucTinnitusLabIOSDeveloperExperienceReflection setDate:@"Apr '13 \u2013 Present"];
	
	WorkExperienceReflection *citesOnsiteConsultantExperienceReflection = [[WorkExperienceReflection alloc] init];
	[citesOnsiteConsultantExperienceReflection setEmployer:@"CITES ONSITE CONSULTING"];
	[citesOnsiteConsultantExperienceReflection setTitle:@"Consultant"];
	[citesOnsiteConsultantExperienceReflection setDescription:@"Facilitated on-site computer consulting services in both home and enterprise environments"];
	[citesOnsiteConsultantExperienceReflection setLocation:@"Urbana, IL"];
	[citesOnsiteConsultantExperienceReflection setDate:@"Sep '12 \u2013 May '13"];
	
	WorkExperienceReflection *universityRelationsOfficeAssistantExperienceReflection = [[WorkExperienceReflection alloc] init];
	[universityRelationsOfficeAssistantExperienceReflection setEmployer:@"UNIVERSITY RELATIONS"];
	[universityRelationsOfficeAssistantExperienceReflection setTitle:@"Office Assistant"];
	[universityRelationsOfficeAssistantExperienceReflection setDescription:@"Updated official records and PrezRelease, the blog of the University of Illinois president"];
	[universityRelationsOfficeAssistantExperienceReflection setLocation:@"Urbana, IL"];
	[universityRelationsOfficeAssistantExperienceReflection setDate:@"Feb '12 \u2013 May '12"];
	
	[_workExperienceReflections addObjectsFromArray:@[iOSInternExperienceReflection, uiucTinnitusLabIOSDeveloperExperienceReflection, citesOnsiteConsultantExperienceReflection, universityRelationsOfficeAssistantExperienceReflection]];
}

- (void)setUpEducationReflections {
	_educationReflections = [NSMutableArray array];
	
	EducationReflection *universityReflection = [[EducationReflection alloc] init];
	[universityReflection setSchool:@"UIUC"];
	[universityReflection setMajor:@"B.S. in E.E."];
	[universityReflection setMinor:@"Minor in C.S."];
	[universityReflection setExpectedGraduationDate:@"May '15"];
	[universityReflection setGpa:@"GPA: 3.65/4.00"];
	
	// education reflection cell supports descriptions, however, the cell looks better without them
//	[universityReflection setDescriptions:@[@"Dean’s List \u2013 Fall '11, Spring '12, Fall '12", @"Member of Eta Kappa Nu (HKN) ECE Honors Society", @"James Scholar", @"Member of Phi Eta Sigma Honors Society"]];
	
	[_educationReflections addObjectsFromArray:@[universityReflection]];
}

- (void)setUpLeadershipAndActivitiesReflections {
	_leadershipAndActivitiesReflections = [NSMutableArray array];
	
	LeadershipAndActivitiesReflection *hknCorporateCommitteeActivity = [[LeadershipAndActivitiesReflection alloc] init];
	[hknCorporateCommitteeActivity setActivity:@"HKN CORPORATE COMMITTEE"];
	[hknCorporateCommitteeActivity setTitle:@"Member"];
	[hknCorporateCommitteeActivity setDescription:@"Foster corporate relations by hosting tech talks and information sessions with employers"];
	[hknCorporateCommitteeActivity setLocation:@"Urbana, IL"];
	[hknCorporateCommitteeActivity setDate:@"Sep '12 \u2013 Present"];
	
	LeadershipAndActivitiesReflection *ieeeActivity = [[LeadershipAndActivitiesReflection alloc] init];
	[ieeeActivity setActivity:@"IEEE"];
	[ieeeActivity setTitle:@"Workshops Committee Member"];
	[ieeeActivity setDescription:@"Maintain communication with a team of engineers to oversee and design future projects"];
	[ieeeActivity setLocation:@"Urbana, IL"];
	[ieeeActivity setDate:@"Oct '11 \u2013 Present"];
	
	LeadershipAndActivitiesReflection *innovationLivingLearningCommunityActivity = [[LeadershipAndActivitiesReflection alloc] init];
	[innovationLivingLearningCommunityActivity setActivity:@"Innovation Living Learning Community"];
	[innovationLivingLearningCommunityActivity setTitle:@"Entrepreneur in Residence "];
	[innovationLivingLearningCommunityActivity setDescription:@"Selected participant for the 2013 Entrepreneurship Workshop in Silicon Valley, hosted by TEC"];
	[innovationLivingLearningCommunityActivity setLocation: @"Urbana, IL"];
	[innovationLivingLearningCommunityActivity setDate:@"Aug '11 \u2013 Present"];
	
	LeadershipAndActivitiesReflection *tutorActivity = [[LeadershipAndActivitiesReflection alloc] init];
	[tutorActivity setActivity:@"Intro to ECE/Computer Engineering I"];
	[tutorActivity setTitle:@"Tutor"];
	[tutorActivity setDescription:@"Provided Supervised Study Sessions (SSS) to help students solve previous exam problems"];
	[tutorActivity setLocation:@"Urbana, IL"];
	[tutorActivity setDate:@"Sep '11 \u2013 May '13"];
	
	[_leadershipAndActivitiesReflections addObjectsFromArray:@[hknCorporateCommitteeActivity, ieeeActivity, innovationLivingLearningCommunityActivity, tutorActivity]];
}

- (void)setUpSkillsReflections {
	_skillsReflections = [[NSMutableArray alloc] init];
	
	NSArray *skills = @[SKILL_C, SKILL_OBJECTIVE_C, SKILL_C_PLUS_PLUS, SKILL_JAVASCRIPT, SKILL_SQL, SKILL_AWS, SKILL_HTML, SKILL_CSS, SKILL_PYTHON, SKILL_GIT, SKILL_LATEX, SKILL_ASSEMBLY, SKILL_COMPUTER_ARCHITECTURE, SKILL_CIRCUIT_DESIGN, SKILL_DIGITAL_SIGNAL_PROCESSING, SKILL_SOLDERING];
	
	SkillsReflection *skillsReflection = [[SkillsReflection alloc] init];
	[skillsReflection setSkills:skills];
	
	[_skillsReflections addObject:skillsReflection];
}

- (void)setUpSkillsWikipediaDict {
	_skillsWikipediaDict = [NSMutableDictionary dictionary];
	
	for (SkillsReflection *skillsReflection in self.skillsReflections) {
		NSArray *skills = skillsReflection.skills;
		
		for (NSString *skill in skills) {
			NSString *url;
			
			if ([skill isEqualToString:SKILL_C]) {
				url = @"http://en.wikipedia.org/wiki/C_(programming_language)";
			}
			
			else if ([skill isEqualToString:SKILL_OBJECTIVE_C]) {
				url = @"http://en.wikipedia.org/wiki/Objective-C";
			}
			
			else if ([skill isEqualToString:SKILL_C_PLUS_PLUS]) {
				url = @"http://en.wikipedia.org/wiki/C%2B%2B";
			}
			
			else if ([skill isEqualToString:SKILL_JAVASCRIPT]) {
				url = @"http://en.wikipedia.org/wiki/JavaScript";
			}
			
			else if ([skill isEqualToString:SKILL_SQL]) {
				url = @"http://en.wikipedia.org/wiki/SQL";
			}
			
			else if ([skill isEqualToString:SKILL_AWS]) {
				url = @"http://en.wikipedia.org/wiki/Amazon_Web_Services";
			}
			
			else if ([skill isEqualToString:SKILL_HTML]) {
				url = @"http://en.wikipedia.org/wiki/HTML";
			}
			
			else if ([skill isEqualToString:SKILL_CSS]) {
				url = @"http://en.wikipedia.org/wiki/CSS";
			}
			
			else if ([skill isEqualToString:SKILL_PYTHON]) {
				url = @"http://en.wikipedia.org/wiki/Python_(programming_language)";
			}
			
			else if ([skill isEqualToString:SKILL_GIT]) {
				url = @"http://en.wikipedia.org/wiki/Git_(software)";
			}
			
			else if ([skill isEqualToString:SKILL_LATEX]) {
				url = @"http://en.wikipedia.org/wiki/LaTeX";
			}
			
			else if ([skill isEqualToString:SKILL_ASSEMBLY]) {
				url = @"http://en.wikipedia.org/wiki/Assembly_language";
			}
			
			else if ([skill isEqualToString:SKILL_COMPUTER_ARCHITECTURE]) {
				url = @"http://en.wikipedia.org/wiki/Computer_architecture";
			}
			
			else if ([skill isEqualToString:SKILL_CIRCUIT_DESIGN]) {
				url = @"http://en.wikipedia.org/wiki/Circuit_design";
			}
			
			else if ([skill isEqualToString:SKILL_DIGITAL_SIGNAL_PROCESSING]) {
				url = @"http://en.wikipedia.org/wiki/Digital_signal_processing";
			}
			
			else if ([skill isEqualToString:SKILL_SOLDERING]) {
				url = @"http://en.wikipedia.org/wiki/Soldering";
			}
			
			else {
				url = @"";
			}
			
			[_skillsWikipediaDict setObject:url forKey:skill];
		}
	}
}

@end
