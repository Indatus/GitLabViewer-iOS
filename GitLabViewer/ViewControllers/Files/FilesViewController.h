//
//  FilesViewController.h
//  GitLabViewer
//
//  Created by Jon Staff on 2/11/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "BaseProjectDetailViewController.h"
#import "ProjectViewController.h"

@class GLFile;

@interface FilesViewController : BaseProjectDetailViewController <ProjectViewController>

@property (nonatomic, strong) NSString *path;

@end
