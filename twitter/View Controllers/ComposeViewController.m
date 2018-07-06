//
//  ComposeViewController.m
//  twitter
//
//  Created by Tiffany Ma on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import <QuartzCore/QuartzCore.h>

@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textCountLabel;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.composeTextView.layer.borderColor = UIColor.grayColor.CGColor;
    self.composeTextView.layer.borderWidth = 2;
    self.composeTextView.layer.cornerRadius = 10;
    self.composeTextView.delegate = self;
    self.textCountLabel.text = @"0/140";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) postTweet{
    NSLog(@"%@", @"HERE");
    [[APIManager shared]postStatusWithText:self.composeTextView.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
    }];
}

- (IBAction)onTapClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTweetPost:(id)sender {
    [self postTweet];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    int characterLimit = 140;
    
    NSString *newText = [self.composeTextView.text stringByReplacingCharactersInRange:range withString:text];
    
    // TODO: Update Character Count Label
    self.textCountLabel.text = [NSString stringWithFormat:@"%lu/140", newText.length];
    return newText.length < characterLimit;
}

@end
