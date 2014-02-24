//
//  BaseProjectDetailViewController.h
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/7/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLProject;

@interface BaseProjectDetailViewController : UITableViewController

@property (nonatomic, strong) GLProject *project;

- (void)fetchData;

@end
