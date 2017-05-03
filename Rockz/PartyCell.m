//
//  PartyCell.m
//  Rockz
//
//  Created by Admin on 10/30/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "PartyCell.h"
#import "Party.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"
#import "Constants.h"

@implementation PartyCell

- (void)setContents:(Party*) party index:(NSInteger)index {
//    self.photoImageView.image = [UIImage imageNamed:party.pictureURL];
    [self.userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROCKZ_PHOTO_URL,party.creator.photoURL]]];
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROCKZ_PARTYIMAGE_URL,party.pictureURL]]];
    NSString *userName;
    if (party.hostList.count == 0) {
        userName = [NSString stringWithFormat:@"%@ %@", party.creator.firstName, party.creator.lastName];
    }else{
        userName = [NSString stringWithFormat:@"%@ %@ +%lu", party.creator.firstName, party.creator.lastName, party.hostList.count];
    }
    self.userNameLabel.text = userName;
    self.partyNameLabel.text = party.name;
    self.partyTimeLabel.text = [NSString stringWithFormat:@"%@ - %@", party.date, party.startTime];
    self.partyLocationLabel.text = party.address;
    self.attendNumberLabel.text = [NSString stringWithFormat:@"%@ attending >",party.numGuest];
    self.userPhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
    [self.attend0PhotoImageView setHidden:YES];
    [self.attend1PhotoImageView setHidden:YES];
    [self.attend2PhotoImageView setHidden:YES];
    [self.attend3PhotoImageView setHidden:YES];
    [self.attend4PhotoImageView setHidden:YES];
    int i = 0;
    for (User *user in party.attendList) {
        switch (i) {
            case 0:
                [self.attend0PhotoImageView setHidden:NO];
                self.attend0PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                [self.attend0PhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@_photo.png",ROCKZ_PHOTO_URL,user.userID]]];
                break;
            case 1:
                [self.attend1PhotoImageView setHidden:NO];
                self.attend1PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                [self.attend1PhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@_photo.png",ROCKZ_PHOTO_URL,user.userID]]];
                break;
            case 2:
                [self.attend2PhotoImageView setHidden:NO];
                self.attend2PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                [self.attend2PhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@_photo.png",ROCKZ_PHOTO_URL,user.userID]]];
                break;
            case 3:
                [self.attend3PhotoImageView setHidden:NO];
                self.attend3PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                [self.attend3PhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@_photo.png",ROCKZ_PHOTO_URL,user.userID]]];
                break;
            case 4:
                [self.attend4PhotoImageView setHidden:NO];
                self.attend4PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                [self.attend4PhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@_photo.png",ROCKZ_PHOTO_URL,user.userID]]];
                break;
            default:
                break;
        }
        i++;
    }

    NSString *statusImage = @"";
    
    switch (party.status) {
        case PS_INVITEONLY:
            statusImage = @"icon_invite_on.png";
            break;
        case PS_PRIVATE:
            statusImage = @"icon_private_on.png";
            break;
        default:
            statusImage = @"icon_public_on.png";
            break;
    }
    self.partyStatusImage.image = [UIImage imageNamed:statusImage];
    
    self.userButton.tag = index;
    self.partyButton.tag = index;
    self.attendingButton.tag = index;
    self.partyStatusButton.tag = index;
    self.locationButton.tag = index;
}

@end
