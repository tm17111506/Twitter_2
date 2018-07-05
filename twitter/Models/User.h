//
//  User.h
//  twitter
//
//  Created by Tiffany Ma on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSURL *userProfileURL;
@property (strong, nonatomic)  NSString *location;
@property (strong, nonatomic)  NSString *summary;
@property (strong, nonatomic)  NSString *followersCount;
@property (strong, nonatomic)  NSString *followingCount;
@property (strong, nonatomic) NSURL *profileBackgroundURL;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
@end
