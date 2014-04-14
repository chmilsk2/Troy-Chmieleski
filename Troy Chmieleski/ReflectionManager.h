//
//  ReflectionManager.h
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReflectionManager : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *workExperienceReflections;
@property (nonatomic, strong, readonly) NSMutableArray *educationReflections;
@property (nonatomic, strong, readonly) NSMutableArray *leadershipAndActivitiesReflections;
@property (nonatomic, strong, readonly) NSMutableArray *skillsReflections;
@property (nonatomic, strong, readonly) NSMutableDictionary *skillsWikipediaDict;

+ (instancetype)sharedReflectionManager;

@end
