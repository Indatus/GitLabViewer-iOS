//
//  FileViewController.h
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/25/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "BaseProjectDetailViewController.h"

@class GLFile;

@interface FileViewController : BaseProjectDetailViewController

@property (nonatomic, strong) GLFile *file;

@end
