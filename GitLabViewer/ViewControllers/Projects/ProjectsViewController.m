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
    
    [[GLGitlabApi sharedInstance] getAllProjectsSuccess:^(NSArray *projects) {
        NSLog(@"Projects: %@", projects);
        _projects = [projects copy];
        [self.tableView reloadData];
    }
                                                failure:^(NSError *error) {
                                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                    message:@"There was an issue fetching projects. Please log in again."
                                                                                                   delegate:nil
                                                                                          cancelButtonTitle:@"OK"
                                                                                          otherButtonTitles:nil];
                                                    [alert show];
                                                    [self dismissViewControllerAnimated:YES completion:nil];
    }];
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
    static NSString *CellIdentifier = @"Cell";
    ProjectsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = (ProjectsCell *) [ProjectsCell new];
    }
    
    [cell setProject:_projects[indexPath.section]];
    
    return cell;
}


#pragma mark - UITableView delegate



@end