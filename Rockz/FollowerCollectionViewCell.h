//
//  FollowerCollectionViewCell.h
//  Rockz
//
//  Created by Admin on 12/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface FollowerCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *userButton;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

- (void)setContents:(User*)user index:(NSInteger)index;
@end
