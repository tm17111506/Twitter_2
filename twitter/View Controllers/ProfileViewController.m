//
//  ProfileViewController.m
//  twitter
//
//  Created by Tiffany Ma on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *userTweetTableView;
@property (strong, nonatomic) NSArray *tweets;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userTweetTableView.dataSource = self;
    // Do any additional setup after loading the view.
    [self fetchTimeline];
    [self setProfile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setProfile{
    self.idLabel.text = [NSString stringWithFormat:@"@%@",self.user.screenName];
    [self.idLabel sizeToFit];
    self.userNameLabel.text = self.user.name;
    [self.userNameLabel sizeToFit];
    
    self.locationLabel.text = self.user.location;
    [self.userNameLabel sizeToFit];
    self.summaryLabel.text = self.user.summary;
    [self.summaryLabel sizeToFit];
    self.followersCount.text = self.user.followersCount;
    [self.followersCount sizeToFit];
    self.followingCount.text = self.user.followingCount;
    [self.followingCount sizeToFit];
    
    [self.userProfileView setImageWithURL:self.user.userProfileURL];
    [self.backgroundImageView setImageWithURL:self.user.profileBackgroundURL];
}

- (void) fetchTimeline{
    [[APIManager shared] userTimeline:self.user.screenName Completion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweets = [NSMutableArray arrayWithArray:tweets];
            [self.userTweetTableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserTweetCell"];
    cell.tweet = self.tweets[indexPath.row];
    [cell setTweetCell:cell.tweet];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
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
