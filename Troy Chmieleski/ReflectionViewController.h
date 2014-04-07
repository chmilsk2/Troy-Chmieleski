//
//  ReflectionViewController.h
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/6/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import <UIKit/UIKit.h>

// Google Analytics
#import "GAITrackedViewController.h"

@interface ReflectionViewController : GAITrackedViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *reflectionTableView;

@end
