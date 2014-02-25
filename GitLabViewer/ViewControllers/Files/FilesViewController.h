//
//  FilesViewController.h
//  GitLabViewer
//
//  Created by Jon Staff on 2/11/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "BaseProjectDetailViewController.h"

@class GLFile;

@interface FilesViewController : BaseProjectDetailViewController

@property (nonatomic, strong) NSString *path;

@end
