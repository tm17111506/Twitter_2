//
//  ReplyViewController.m
//  twitter
//
//  Created by Tiffany Ma on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ReplyViewController.h"
#import "APIManager.h"

@interface ReplyViewController ()
@property (weak, nonatomic) IBOutlet UITextView *replyTextView;

@end

@implementation ReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.replyTextView.layer.borderColor = UIColor.grayColor.CGColor;
    self.replyTextView.layer.borderWidth = 2;
    self.replyTextView.layer.cornerRadius = 10;
}

- (void) postReply{
    NSString *replyText = [NSString stringWithFormat:@"@%@ %@", self.tweet.user.screenName, self.replyTextView.text];
    NSLog(@"%@", @"HERE");
    NSLog(@"%@", self.tweet.idString);
    [[APIManager shared] postReply:self.tweet.idString WithText:replyText completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Compose Tweet Success!");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onTapClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onTapReply:(UIBarButtonItem *)sender {
    [self postReply];
    [self dismissViewControllerAnimated:YES completion:nil];
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
