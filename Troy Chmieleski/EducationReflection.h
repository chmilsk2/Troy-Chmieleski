//
//  EducationReflection.h
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/7/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "Reflection.h"

@interface EducationReflection : Reflection

@property (nonatomic, strong) NSString *school;
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSString *minor;
@property (nonatomic, strong) NSString *expectedGraduationDate;
@property (nonatomic, strong) NSString *gpa;
@property (nonatomic, strong) NSArray *descriptions;

@end
