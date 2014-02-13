//
//  ProjectsViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/4/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "ProjectsViewController.h"
#import <GLGitlab.h>
#import "ProjectsCell.h"
#import "ProjectMenuViewController.h"
#import "UserPreferences.h"
#import "LoginViewController.h"
#import "CreateProjectViewController.h"

static NSString *const kCellIdentifier = @"Cell";

@interface ProjectsViewController ()
{
    NSMutableArray *_projects;
}

@end

@implementation ProjectsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"ProjectsCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:kCellIdentifier];
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
    self.navigationItem.leftBarButtonItem = logoutButton;
    
    UIBarButtonItem *addProjectButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showCreateProjectView)];
    self.navigationItem.rightBarButtonItem = addProjectButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _projects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = (ProjectsCell *) [ProjectsCell new];
    }
    
    [cell setProject:_projects[indexPath.section]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return ((GLProject *)_projects[section]).glNamespace.name;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GLProject *selectedProject = _projects[indexPath.section];
    ProjectMenuViewController *menuViewController = [ProjectMenuViewController new];
    menuViewController.project = selectedProject;
    [self.navigationController pushViewController:menuViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}


#pragma mark - Custom Private Methods

- (void)logOut
{
    UserPreferences *prefs = [UserPreferences sharedInstance];
    prefs.loggedIn = NO;
    
    LoginViewController *loginVC = [LoginViewController new];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)showCreateProjectView
{
    UINavigationController *tempNav = [[UINavigationController alloc] initWithRootViewController:[CreateProjectViewController new]];
    [self presentViewController:tempNav animated:YES completion:nil];
}

@end