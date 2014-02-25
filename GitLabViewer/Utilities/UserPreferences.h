//
//  UserPreferences.h
//  GitLabViewer
//
//  Created by Jon Staff on 2/11/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPreferences : NSObject

@property (nonatomic, assign, getter = isLoggedIn) BOOL loggedIn;
@property (nonatomic, copy) NSString *hostname;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong) GLUser *user;

+ (UserPreferences *)sharedInstance;

@end