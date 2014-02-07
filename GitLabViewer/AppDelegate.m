//
//  AppDelegate.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/4/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "ProjectsViewController.h"
#import "IssuesViewController.h"
#import "MergeRequestsViewController.h"
#import "HelpViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self setUpViews];
    [self presentLoginIfNeeded];
    
    
    return YES;
}

#pragma mark - Custom Methods

- (void)setUpViews
{
    ProjectsViewController *projectsVC = [[ProjectsViewController alloc] initWithStyle:UITableViewStylePlain];
    projectsVC.title = @"Projects";
    _navController = [[UINavigationController alloc] initWithRootViewController:projectsVC];

    [_window setRootViewController:_navController];
    [_window makeKeyAndVisible];
}

- (void)presentLoginIfNeeded
{
    LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    [_navController.topViewController presentViewController:loginView animated:NO completion:nil];
}

@end