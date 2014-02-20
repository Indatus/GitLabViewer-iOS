//
//  AppDelegate.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/4/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ProjectsViewController.h"
#import "IssuesViewController.h"
#import "MergeRequestsViewController.h"
#import "UserPreferences.h"
#import "GLNavigationController.h"

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
    _projectsVC = [[ProjectsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    _projectsVC.title = @"Projects";

    _navController = [[GLNavigationController alloc] initWithRootViewController:_projectsVC];

    [_window setRootViewController:_navController];
    [_window makeKeyAndVisible];
}

- (void)presentLoginIfNeeded
{
    UserPreferences *prefs = [UserPreferences sharedInstance];
    if (prefs.loggedIn) {
        [[GLGitlabApi sharedInstance] loginToHost:prefs.hostname
                                         username:prefs.username
                                         password:prefs.password
                                          success:^(GLUser *user) {
                                              NSLog(@"The user is: %@", user);
                                              
                                              [[GLGitlabApi sharedInstance] getUsersProjectsSuccess:^(NSArray *projects) {
                                                  NSLog(@"Projects: %@", projects);
                                                  _projectsVC.projects = [projects copy];
                                                  [_projectsVC.tableView reloadData];
                                                  // TODO: show animation until this is finished...
                                              }
                                                                                            failure:^(NSError *error) {
                                                                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                                                                message:@"There was an issue fetching projects. Please sign in again."
                                                                                                                                               delegate:nil
                                                                                                                                      cancelButtonTitle:@"OK"
                                                                                                                                      otherButtonTitles:nil];
                                                                                                [alert show];
                                                                                            }];
                                              
                                          }
                                          failure:^(NSError *error) {
                                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                              message:@"There was an issue logging in. Please check the credentials and try again."
                                                                                             delegate:nil
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil];
                                              [alert show];
                                          }];

    } else {
        LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
        [_navController.topViewController presentViewController:loginView animated:NO completion:nil];
    }
}

@end