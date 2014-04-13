//
//  MenuProfileCell.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/8/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "MenuProfileCell.h"

#define VERTICAL_MARGIN 30.0f

// Profile view
#define PROFILE_IMAGE_SIZE 128.0f
#define PROFILE_IMAGE_NAME @"Troy Chmieleski Profile"
#define PROFILE_VIEW_BORDER_WIDTH 3.0f
#define PROFILE_VIEW_SHADOW_OPACITY 0.25f
#define PROFILE_VIEW_SHADOW_WIDTH 1.0f
#define PROFILE_VIEW_BORDER_WIDTH 3.0f
#define PROFILE_VIEW_SIZE (PROFILE_IMAGE_SIZE + 2*PROFILE_VIEW_BORDER_WIDTH)

// Name label
#define NAME @"TROY SCOTT CHMIELESKI"
#define NAME_LABEL_FONT_SIZE 16.0f

@interface MenuProfileCell ()

@property (nonatomic, strong) UIView *profileView;
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UIView *profileBackgroundView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation MenuProfileCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
    if (self) {
		[self setClipsToBounds:YES];
		
		[self addSubview:self.backgroundImageView];
		[self addSubview:self.profileView];
		[self addSubview:self.nameLabel];
		
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		
		[self setBackgroundColor:[UIColor clearColor]];
    }
	
    return self;
}

#pragma mark - Height

- (CGFloat)height {
	CGFloat height = 0;
	
	height += VERTICAL_MARGIN;
	
	// profile view
	height += PROFILE_VIEW_SIZE;
	
	height += VERTICAL_MARGIN;
	
	// name label
	CGRect nameLabelRect = [self nameLabelRectWithName:NAME];
	height += nameLabelRect.size.height;
	
	height += VERTICAL_MARGIN;
	
	return height;
}

- (void)hideBackgroundImageView {
	[self.backgroundImageView setHidden:YES];
}

- (void)showBackgroundImageView {
	[self.backgroundImageView setHidden:NO];
}

#pragma mark - Profile view

- (UIView *)profileView {
	if (!_profileView) {
		_profileView = [[UIView alloc] initWithFrame:CGRectZero];
		[_profileView setBackgroundColor:[UIColor whiteColor]];
		[_profileView.layer setCornerRadius:PROFILE_VIEW_SIZE/2];
		
		[_profileView.layer setShadowOffset:CGSizeMake(1, 2)];
		[_profileView.layer setShadowRadius:PROFILE_VIEW_SHADOW_WIDTH];
		[_profileView.layer setShadowOpacity:PROFILE_VIEW_SHADOW_OPACITY];
		
		[self.profileView addSubview:self.profileBackgroundView];
		[self.profileView addSubview:self.profileImageView];
	}
	
	return _profileView;
}

- (UIImageView *)profileImageView {
	if (!_profileImageView) {
		_profileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:PROFILE_IMAGE_NAME]];
		[_profileImageView.layer setCornerRadius:PROFILE_IMAGE_SIZE/2];
		[_profileImageView.layer setMasksToBounds:YES];
	}
	
	return _profileImageView;
}

- (UIView *)profileBackgroundView {
	if (!_profileBackgroundView) {
		_profileBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
		[_profileBackgroundView.layer setCornerRadius:PROFILE_VIEW_SIZE/2];
		[_profileBackgroundView.layer setMasksToBounds:YES];
		[_profileBackgroundView setBackgroundColor:[UIColor whiteColor]];
	}
	
	return _profileBackgroundView;
}

#pragma mark - Name label

- (UILabel *)nameLabel {
	if (!_nameLabel) {
		_nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_nameLabel setText:NAME];
		[_nameLabel setTextColor:[UIColor whiteColor]];
		[_nameLabel setFont:[self nameLabelFont]];
	}
	
	return _nameLabel;
}

- (CGRect)nameLabelRectWithName:(NSString *)name {
	CGRect nameLabelRect = CGRectIntegral([name boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self nameLabelFont]} context:nil]);
	
	return nameLabelRect;
}

- (UIFont *)nameLabelFont {
	UIFont *nameLabelFont = [UIFont boldSystemFontOfSize:NAME_LABEL_FONT_SIZE];
	
	return nameLabelFont;
}

#pragma mark - Background Image View

- (UIImageView *)backgroundImageView {
	if (!_backgroundImageView) {
		_backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Earth"]];
		[_backgroundImageView setContentMode:UIViewContentModeTopLeft];
	}
	
	return _backgroundImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
	// profile view
	[self.profileView setFrame:CGRectMake((self.bounds.size.width - PROFILE_VIEW_SIZE)/2, VERTICAL_MARGIN, PROFILE_VIEW_SIZE, PROFILE_VIEW_SIZE)];
	[self.profileBackgroundView setFrame:self.profileView.bounds];
	
	[self.profileImageView setFrame:CGRectMake(PROFILE_VIEW_BORDER_WIDTH, PROFILE_VIEW_BORDER_WIDTH, PROFILE_IMAGE_SIZE, PROFILE_IMAGE_SIZE)];
	
	// name label
	CGRect nameLabelRect = [self nameLabelRectWithName:self.nameLabel.text];
	
	[self.nameLabel setFrame:CGRectMake((self.bounds.size.width - nameLabelRect.size.width)/2, self.profileView.frame.origin.y + self.profileView.bounds.size.height + VERTICAL_MARGIN, nameLabelRect.size.width, nameLabelRect.size.height)];
	
	// background image view
	CGPoint contentOffset;
	
	if ([self.delegate respondsToSelector:@selector(contentOffsetForMenuProfileCell:)]) {
		contentOffset = [self.delegate contentOffsetForMenuProfileCell:self];
	}
	
	[self.backgroundImageView setFrame:CGRectMake(contentOffset.x, contentOffset.y, self.backgroundImageView.image.size.width, self.backgroundImageView.image.size.height)];
}

@end
