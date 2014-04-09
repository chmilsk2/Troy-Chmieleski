//
//  MenuCell.m
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/8/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "MenuCell.h"

// Menu item
#define ITEM_LABEL_HORIZONTAL_MARGIN 14.0f
#define ITEM_LABEL_FONT_SIZE 16.0f

// Menu footer
#define FOOTER_VIEW_HEIGHT 1.0f

@interface MenuCell ()

@property (nonatomic, strong) UIView *footerView;

@end

@implementation MenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
    if (self) {
		[self addSubview:self.itemLabel];
        [self addSubview:self.footerView];
    }
	
    return self;
}

#pragma mark - Item Label

- (UILabel *)itemLabel {
	if (!_itemLabel) {
		_itemLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_itemLabel setFont:[self itemLabelFont]];
	}
	
	return _itemLabel;
}

- (UIFont *)itemLabelFont {
	UIFont *itemLabelFont = [UIFont boldSystemFontOfSize:ITEM_LABEL_FONT_SIZE];
	
	return itemLabelFont;
}

#pragma mark - Footer view 

- (UIView *)footerView {
	if (!_footerView) {
		_footerView = [[UIView alloc] initWithFrame:CGRectZero];
		[_footerView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
	}
	
	return _footerView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
	// item label
	CGRect itemRect = CGRectIntegral([self.itemLabel.text boundingRectWithSize:CGSizeMake(self.bounds.size.width - 2*ITEM_LABEL_HORIZONTAL_MARGIN, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [self itemLabelFont]} context:nil]);
	
	[self.itemLabel setFrame:CGRectMake(ITEM_LABEL_HORIZONTAL_MARGIN, (self.bounds.size.height - itemRect.size.height)/2, itemRect.size.width, itemRect.size.height)];
	
	// footer view
	[self.footerView setFrame:CGRectMake(0, self.bounds.size.height - FOOTER_VIEW_HEIGHT, self.bounds.size.width, FOOTER_VIEW_HEIGHT)];
}

@end
