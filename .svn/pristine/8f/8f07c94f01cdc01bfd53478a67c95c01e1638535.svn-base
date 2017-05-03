//
//  UserCollectionCell.m
//  Rockz
//
//  Created by Admin on 11/3/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "UserCollectionCell.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"

@implementation UserCollectionCell

- (void)setContents:(User*)user index:(NSInteger)index {
    
    [self.userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", ROCKZ_PHOTO_URL, user.photoURL] ]];
    self.userPhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
    self.userNameLabel.text = [NSString stringWithFormat:@"%@\n%@", user.firstName, user.lastName];
    [self.actionButton setImage:[UIImage imageNamed:@"btn_userprofile_unfollow.png"] forState:UIControlStateNormal];
    self.actionButton.tag = index;
}

@end
