//
//  FollowerCollectionViewCell.m
//  Rockz
//
//  Created by Admin on 12/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "FollowerCollectionViewCell.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"

@implementation FollowerCollectionViewCell

- (void)setContents:(User*)user index:(NSInteger)index {
    
    [self.userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", ROCKZ_PHOTO_URL, user.photoURL] ]];
    self.userPhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
    self.userNameLabel.text = [NSString stringWithFormat:@"%@\n%@", user.firstName, user.lastName];
    
    if (user.attend_status == ALLOW_ATTENDING) {
        [self.actionButton setImage:[UIImage imageNamed:@"btn_attenders_following"] forState:UIControlStateNormal];
    } else{
        [self.actionButton setImage:[UIImage imageNamed:@"btn_attenders_follow.png"] forState:UIControlStateNormal];

    }
    self.actionButton.tag = index;
}

@end
