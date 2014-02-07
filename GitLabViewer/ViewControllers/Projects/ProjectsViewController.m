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
    UINib *nib = [UINib nibWithNibName:@"ProjectsCell"
                                bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:kCellIdentifier];
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

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GLProject *selectedProject = _projects[indexPath.row];
    ProjectMenuViewController *menuViewController = [ProjectMenuViewController new];
    menuViewController.project = selectedProject;
    [self.navigationController pushViewController:menuViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end