//
//  BaseProjectDetailViewController.m
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/7/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "BaseProjectDetailViewController.h"

@interface BaseProjectDetailViewController ()

@end

@implementation BaseProjectDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchData];
}

- (void)fetchData
{
    [NSException raise:@"NSInternalInconsistentState"
                format:@"Fetch data must be overriden in inheriting classes"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
