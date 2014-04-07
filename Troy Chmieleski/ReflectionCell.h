//
//  ReflectionCell.h
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/6/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReflectionCell;
@class Reflection;

@protocol ReflectionCelDelegate <NSObject>

- (CGPoint)contentOffsetForReflectionCell:(ReflectionCell *)reflectionCell;

@end

@interface ReflectionCell : UITableViewCell

@property (weak) id <ReflectionCelDelegate> delegate;
@property (nonatomic, strong) UIView *reflectionBackgroundView;
@property (nonatomic, strong) UIView *backgroundTintView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

- (UIImage *)reflectionBackgroundViewImage;
- (void)setReflectionBackgroundViewImage:(UIImage *)image;

@end
