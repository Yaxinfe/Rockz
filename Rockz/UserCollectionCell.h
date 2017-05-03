//
//  UserCollectionCell.h
//  Rockz
//
//  Created by Admin on 11/3/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface UserCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *userButton;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

- (void)setContents:(User*)user index:(NSInteger)index;

@end
