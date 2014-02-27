//
//  UserPreferences.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/11/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "UserPreferences.h"

@interface UserPreferences () {
    NSUserDefaults *_userDefaults;
}

@end

@implementation UserPreferences

NSString * const kLoggedIn = @"logged_in";
NSString * const kHostname = @"hostname";
NSString * const kUsername = @"username";
NSString * const kPassword = @"password";
NSString * const kUser = @"user";

static UserPreferences *_instance;

- (instancetype)init
{
    if (self = [super init]) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

+ (UserPreferences *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [UserPreferences new];
    });
    
    return _instance;
}


#pragma mark - Custom Accessor Methods

- (void)setLoggedIn:(BOOL)loggedIn
{
    [_userDefaults setBool:loggedIn forKey:kLoggedIn];
    [_userDefaults synchronize];
}

- (BOOL)isLoggedIn
{
    return [_userDefaults boolForKey:kLoggedIn];
}

- (void)setHostname:(NSString *)hostname
{
    [_userDefaults setObject:hostname forKey:kHostname];
    [_userDefaults synchronize];
}

- (NSString *)hostname
{
    return [_userDefaults objectForKey:kHostname];
}

- (void)setUsername:(NSString *)username
{
    [_userDefaults setObject:username forKey:kUsername];
    [_userDefaults synchronize];
}

- (NSString *)username
{
    return [_userDefaults objectForKey:kUsername];
}

- (void)setPassword:(NSString *)password
{
    [_userDefaults setObject:password forKey:kPassword];
    [_userDefaults synchronize];
}

- (NSString *)password
{
    return [_userDefaults objectForKey:kPassword];
}

- (void)setUser:(GLUser *)user
{
    [_userDefaults setObject:[user jsonString] forKey:kUser];
    [_userDefaults synchronize];
}

- (GLUser *)user
{
    NSError *error;
    NSDictionary *json =
    [NSJSONSerialization JSONObjectWithData: [[_userDefaults objectForKey:kUser] dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &error];
    
    return [[GLUser alloc] initWithJSON:json];
}


@end