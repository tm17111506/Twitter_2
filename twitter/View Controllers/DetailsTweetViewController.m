//
//  DetailsTweetViewController.m
//  twitter
//
//  Created by Tiffany Ma on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailsTweetViewController.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "ProfileViewController.h"
#import "ReplyViewController.h"

@interface DetailsTweetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userProfileView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation DetailsTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDetailsTweet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDetailsTweet{
    self.tweetTextLabel.text = self.tweet.text;
    [self.tweetTextLabel sizeToFit];
    self.idLabel.text = [NSString stringWithFormat:@"@%@",self.tweet.user.screenName];
    [self.idLabel sizeToFit];
    self.userNameLabel.text = self.tweet.user.name;
    [self.userNameLabel sizeToFit];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    [self.favoriteCountLabel sizeToFit];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    [self.retweetCountLabel sizeToFit];
    
    self.createdDateLabel.text = self.tweet.createdAtString;
    
    [self.userProfileView setImageWithURL:self.tweet.user.userProfileURL];
    self.userProfileView.layer.cornerRadius = 20;

    if(self.tweet.retweeted) self.retweetButton.selected = YES;
    else self.retweetButton.selected = NO;
    
    if(self.tweet.favorited) self.favoriteButton.selected = YES;
    else self.favoriteButton.selected = NO;
}

- (IBAction)onTapRetweet:(id)sender {
    if(self.tweet.retweeted){
        self.tweet.retweeted = NO;
        self.retweetButton.selected = NO;
        self.tweet.retweetCount -= 1;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweet tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweet the following Tweet: %@", tweet.text);
            }
        }];
    }
    else{
        self.tweet.retweeted = YES;
        self.retweetButton.selected = YES;
        self.tweet.retweetCount += 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweet tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweet the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self refreshData];
}

- (IBAction)onTapFavorite:(id)sender {
    if(self.tweet.favorited){ //Unfavoring
        self.tweet.favorited = NO;
        self.favoriteButton.selected = NO;
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else{
        self.tweet.favorited = YES;
        self.favoriteButton.selected = YES;
        self.tweet.favoriteCount += 1;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self refreshData];
}

-(void)refreshData{
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqual:@"TweetProfileView"]){
        ProfileViewController *profileViewController = [segue destinationViewController];
        profileViewController.user = self.tweet.user;
    }
    else if([segue.identifier isEqual:@"ReplyView"]){
        UINavigationController *navController = [segue destinationViewController];
        ReplyViewController *replyViewController = (ReplyViewController*)navController.topViewController;
        replyViewController.tweet = self.tweet;
        NSLog(@"%@", self.tweet);
    }
}


@end
