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

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweetCell:(Tweet*)tweet{
    _tweet = tweet;
    self.tweetTextLabel.text = tweet.text;
    self.userNameLabel.text = tweet.user.name;
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.createdDateLabel.text = tweet.createdAtString;
    
    [self.userProfileView setImageWithURL:tweet.user.userProfileURL];
}

@end
