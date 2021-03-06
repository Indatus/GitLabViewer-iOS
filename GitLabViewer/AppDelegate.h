//
//  AppDelegate.h
//  GitLabViewer
//
//  Created by Jon Staff on 2/4/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProjectsViewController, GLNavigationController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) GLNavigationController *navController;
@property (nonatomic, strong) ProjectsViewController *projectsVC;

@end
