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
    [self setUpViews];
    [self presentLoginIfNeeded];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Custom Methods

- (void)setUpViews
{
    ProjectsViewController *projectsVC = [ProjectsViewController new];
    projectsVC.title = @"Projects";
    UINavigationController *projectsNav = [[UINavigationController alloc] initWithRootViewController:projectsVC];
    
    IssuesViewController *issuesVC = [IssuesViewController new];
    issuesVC.title = @"Issues";
    UINavigationController *issuesNav = [[UINavigationController alloc] initWithRootViewController:issuesVC];
    
    HomeViewController *homeVC = [HomeViewController new];
    homeVC.title = @"Home";
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    MergeRequestsViewController *mergeRequestsVC = [MergeRequestsViewController new];
    mergeRequestsVC.title = @"Merge Requests";
    UINavigationController *mergeRequestsNav = [[UINavigationController alloc] initWithRootViewController:mergeRequestsVC];
    
    HelpViewController *helpVC = [HelpViewController new];
    helpVC.title = @"Help";
    UINavigationController *helpNav = [[UINavigationController alloc] initWithRootViewController:helpVC];
    
    _tabBarController.viewControllers = @[projectsNav, issuesNav, homeNav, mergeRequestsNav, helpNav];
    [_window setRootViewController:_tabBarController];
    [_window makeKeyAndVisible];
}

- (void)presentLoginIfNeeded
{
    LoginViewController *loginView = [LoginViewController new];
    [_tabBarController presentViewController:loginView animated:YES completion:nil];
}

@end