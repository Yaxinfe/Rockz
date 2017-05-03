//
//  NotificationCell.h
//  Rockz
//
//  Created by Admin on 11/1/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Notification.h"

@interface NotificationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *message1Label;
@property (weak, nonatomic) IBOutlet UILabel *message2Label;
@property (weak, nonatomic) IBOutlet UILabel *message3Label;
@property (weak, nonatomic) IBOutlet UIImageView *actionImageView;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;


- (void)setContents:(Notification*)notification index:(NSInteger)index;

@end
