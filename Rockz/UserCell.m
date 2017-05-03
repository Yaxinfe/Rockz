//
//  UserCell.m
//  Rockz
//
//  Created by Admin on 11/1/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "UserCell.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"

@implementation UserCell

- (void)setContents:(User*)user index:(NSInteger)index {
    [self.userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", ROCKZ_PHOTO_URL, user.photoURL]]];
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
//    makeCircleImageView(self.userPhotoImageView, 1.0f);
    self.userPhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
    
    if (self.userButton) {
        self.userButton.tag = index;
    }
}

@end
