//
//  User.m
//  twitter
//
//  Created by Tiffany Ma on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.userProfileURL = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        self.location = dictionary[@"location"];
        self.summary = @"";
        if(dictionary[@"description"] != nil){
            self.summary = dictionary[@"description"];
        }
        self.followersCount = [NSString stringWithFormat:@"%@",dictionary[@"followers_count"]];
        self.followingCount = [NSString stringWithFormat:@"%@", dictionary[@"friends_count"]];
        NSLog(@"%@", dictionary[@"profile_banner_url"]);
        self.profileBackgroundURL = [NSURL URLWithString:dictionary[@"profile_banner_url"]];
    }
    return self;
}
@end
