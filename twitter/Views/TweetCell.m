//
//  TweetCell.m
//  twitter
//
//  Created by Tiffany Ma on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

- (void)setTweetCell:(Tweet*)tweet{
    _tweet = tweet;
    self.tweetTextLabel.text = tweet.text;
    [self.tweetTextLabel sizeToFit];
    self.idLabel.text = [NSString stringWithFormat:@"@%@",self.tweet.user.screenName];
    self.userNameLabel.text = tweet.user.name;
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    [self.favoriteCountLabel sizeToFit];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    [self.retweetCountLabel sizeToFit];
    
    self.createdDateLabel.text = tweet.timeAgo;
    
    if(self.tweet.retweeted) self.retweetButton.selected = YES;
    else self.retweetButton.selected = NO;
    
    if(self.tweet.favorited) self.favoriteButton.selected = YES;
    else self.favoriteButton.selected = NO;
    
    [self.userProfileView setImageWithURL:tweet.user.userProfileURL];
}

@end
