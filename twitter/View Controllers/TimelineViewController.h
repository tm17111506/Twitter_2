//
//  TimelineViewController.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComposeViewController.h"

@interface TimelineViewController : UIViewController <UITableViewDataSource, ComposeViewControllerDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *tweets;
@end
