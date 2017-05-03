//
//  NotificationCell.m
//  Rockz
//
//  Created by Admin on 11/1/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NotificationCell.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"
#import "User.h"

@implementation NotificationCell

- (void)setContents:(Notification*)notification index:(NSInteger)index {
    User *user = [[User alloc] init];
    user = notification.user;
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",ROCKZ_PHOTO_URL, user.photoURL];
    [self.userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    self.userPhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
    
    NSString *typeImage = @"";
    
    switch (notification.type) {
        case NT_POSTED:
            typeImage = @"icon_invite_on.png";
            break;
        case NT_REQUEST:
            typeImage = @"icon_private_on.png";
            break;
        case NT_FOLLOWING:
            typeImage = @"icon_public_on.png";
            break;
    }
    
    _message1Label.text = notification.message;
    self.actionImageView.image = [UIImage imageNamed:typeImage];
    self.actionButton.tag = index;
    
    _message2Label.hidden = YES;
    _message3Label.hidden = YES;
}

@end
