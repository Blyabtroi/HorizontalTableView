//
//  HorizontalTableViewCell.h
//  Horizontal TableView
//
//  Created by Vasiliy Kozlov on 23.12.15.
//  Copyright © 2015 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *paramImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

-(UIImage *) cellImageSelected:(BOOL)selected;

@end
