//
//  HorizontalTableViewCell.m
//  Horizontal TableView
//
//  Created by Vasiliy Kozlov on 23.12.15.
//  Copyright © 2015 . All rights reserved.
//

#import "HorizontalTableViewCell.h"

@implementation HorizontalTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    self.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIImage *) cellImageSelected:(BOOL)selected {
    return (selected ? [UIImage imageNamed:@"from-whence-blue"] : [UIImage imageNamed:@"from-whence-grey"]);
}

@end
