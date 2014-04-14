//
//  ReflectionManager.h
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReflectionManager : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *goalsReflections;
@property (nonatomic, strong, readonly) NSMutableArray *experienceReflections;
@property (nonatomic, strong, readonly) NSMutableArray *educationReflections;
@property (nonatomic, strong, readonly) NSMutableArray *leadershipAndActivitiesReflections;
@property (nonatomic, strong, readonly) NSMutableArray *skillsReflections;

+ (instancetype)sharedReflectionManager;

@end
