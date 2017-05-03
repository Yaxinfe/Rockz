//
//  AttenderCell.m
//  Rockz
//
//  Created by Admin on 11/1/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AttenderCell.h"
#import "UIImageView+WebCache.h"

@implementation AttenderCell

- (void)setContents:(User*)user index:(NSInteger)index {
    [self.userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:user.photoURL]];
    self.userPhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
    
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    
    if (user.attend_status == 0) {
        self.followImageView.image = [UIImage imageNamed:@"btn_attenders_following.png"];
    } else {
        self.followImageView.image = [UIImage imageNamed:@"btn_attenders_follow.png"];
    }
}

@end
