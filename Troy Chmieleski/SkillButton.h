//
//  SkillButton.h
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/14/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SkillButton;

@protocol SkillButtonDelegate <NSObject>

- (CGRect)skillRectForSkillButton:(SkillButton *)skillButton;

@end

@interface SkillButton : UIButton

@property (weak) id <SkillButtonDelegate> delegate;
@property (nonatomic, strong) UILabel *skillLabel;

- (CGFloat)widthWithSkillRect:(CGRect)skillRect;
- (CGFloat)heightWithSkillRect:(CGRect)skillRect;

@end
