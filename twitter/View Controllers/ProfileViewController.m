//
//  ProfileViewController.m
//  twitter
//
//  Created by Tiffany Ma on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setProfile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setProfile{
    self.idLabel.text = [NSString stringWithFormat:@"@%@",self.tweet.user.screenName];
    [self.idLabel sizeToFit];
    self.userNameLabel.text = self.tweet.user.name;
    [self.userNameLabel sizeToFit];
    
    self.locationLabel.text = self.tweet.user.location;
    [self.userNameLabel sizeToFit];
    self.summaryLabel.text = self.tweet.user.summary;
    [self.summaryLabel sizeToFit];
    self.followersCount.text = self.tweet.user.followersCount;
    [self.followersCount sizeToFit];
    self.followingCount.text = self.tweet.user.followingCount;
    [self.followingCount sizeToFit];
    
    [self.userProfileView setImageWithURL:self.tweet.user.userProfileURL];
    [self.backgroundImageView setImageWithURL:self.tweet.user.profileBackgroundURL];
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
