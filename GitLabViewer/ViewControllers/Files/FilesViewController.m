//
//  FilesViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/11/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "FilesViewController.h"
#import <GLProject.h>
#import <GLFile.h>
#import <GLNetworkOperation.h>
#import <GLGitlabApi+Files.h>
#import "FileViewController.h"
#import "FileCell.h"
#import "ProjectViewController.h"

@interface FilesViewController ()
@property (nonatomic, strong) GLNetworkOperation *operation;
@property (nonatomic, strong) NSArray *files;
@end

@implementation FilesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"FileCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_operation) {
        [_operation cancel];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    GLFile *file = _files[indexPath.row];
    [cell setupWithFile:file];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController <ProjectViewController> *controller;
    GLFile *file = _files[indexPath.row];
    switch (file.type) {
        case GLFileTypeTree:
            controller = [self prepareFilesViewControllerWithPath:file.name];
            break;
            
        case GLFileTypeBlob:
            controller = [self prepareVilewViewControllerWithFile:file];
            break;
    }
    controller.project = self.project;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Private Methods

- (void)fetchData
{
    self.operation = [[GLGitlabApi sharedInstance] getRepositoryTreeForProjectId:self.project.projectId
                                                                            path:_path
                                                                      branchName:nil
                                                                withSuccessBlock:^(NSArray *files) {
                                                                    self.files = files;
                                                                    [self.tableView reloadData];
                                                                }
                                                                 andFailureBlock:^(NSError *error) {
                                                                     NSLog(@"Error fetching files: %@", error);
                                                                 }];
}

- (UIViewController<ProjectViewController> *)prepareFilesViewControllerWithPath:(NSString *)path
{
    FilesViewController *controller = [[FilesViewController alloc] init];
    controller.path = _path ? [_path stringByAppendingPathComponent:path] : path;
    return controller;
}

- (UIViewController<ProjectViewController> *)prepareVilewViewControllerWithFile:(GLFile *)file
{
    FileViewController *controller = [[FileViewController alloc] init];
    controller.file = file;
    
    return controller;
}

@end
