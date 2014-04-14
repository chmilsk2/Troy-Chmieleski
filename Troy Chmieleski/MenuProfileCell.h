//
//  MenuProfileCell.h
//  Troy Chmieleski
//
//  Created by Troy Chmieleski on 4/8/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuProfileCell;

@protocol MenuProfileCellDelegate <NSObject>

- (CGPoint)contentOffsetForMenuProfileCell:(MenuProfileCell *)menuProfileCell;

@end

@interface MenuProfileCell : UITableViewCell

@property (weak) id <MenuProfileCellDelegate> delegate;

- (CGFloat)height;
- (void)hideBackgroundImageView;
- (void)showBackgroundImageView;

@end
