//
//  TipsViewController.m
//  Rockz
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "TipsViewController.h"
#import "PartyFeedViewController.h"

@interface TipsViewController ()

@end

@implementation TipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.yourProfileImageView.hidden = NO;
    self.partyFeedImageView.hidden = YES;
    self.partyFeedImageView.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.partyFeedImageView.hidden) {
        self.partyFeedImageView.alpha = 0;
        self.partyFeedImageView.hidden = NO;
        [UIView animateWithDuration:0.5f
                              delay:0.0f
                            options:0
                         animations:^{
                             self.partyFeedImageView.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                         }];
    } else {
        PartyFeedViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PartyFeedViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
