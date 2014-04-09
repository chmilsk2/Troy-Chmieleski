//
//  ReflectionCell.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/6/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "ReflectionCell.h"

#import "Reflection.h"

// background tint view
#define BACKGROUND_TINT_VIEW_OPACITY 0.4

@implementation ReflectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
    if (self) {
		[self addSubview:self.reflectionBackgroundView];
    }
	
    return self;
}

#pragma mark - Reflection background view

- (UIView *)reflectionBackgroundView {
	if (!_reflectionBackgroundView) {
		_reflectionBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
		
		[_reflectionBackgroundView setClipsToBounds:YES];
		
		// background image view
		_backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		
		// bakckground tint view
		_backgroundTintView = [[UIView alloc] initWithFrame:CGRectZero];
		[_backgroundTintView setBackgroundColor:[UIColor blackColor]];
		[_backgroundTintView setAlpha:BACKGROUND_TINT_VIEW_OPACITY];
		
		[_reflectionBackgroundView addSubview:_backgroundImageView];
		[_reflectionBackgroundView addSubview:_backgroundTintView];
	}
	
	return _reflectionBackgroundView;
}

- (UIImage *)reflectionBackgroundViewImage {
	return _backgroundImageView.image;
}

- (void)setReflectionBackgroundViewImage:(UIImage *)image {
	[_backgroundImageView setImage:image];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
	// reflection background view
	[self.reflectionBackgroundView setFrame:self.bounds];
	[self.backgroundTintView setFrame:self.bounds];
	
	UIImage *backgroundImage = [self reflectionBackgroundViewImage];
	
	CGPoint contentOffset;
	
	if ([self.delegate respondsToSelector:@selector(contentOffsetForReflectionCell:)]) {
		contentOffset = [self.delegate contentOffsetForReflectionCell:self];
	}
	
	[self.backgroundImageView setFrame:CGRectMake(contentOffset.x, contentOffset.y, backgroundImage.size.width, backgroundImage.size.height)];
}

@end
