//
//  ComposeViewController.h
//  twitter
//
//  Created by Tiffany Ma on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@protocol ComposeViewControllerDelegate
- (void)didTweet:(Tweet *)tweet;
@end

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *composeTextView;
@property (weak, nonatomic) id<ComposeViewControllerDelegate> delegate;
@end



