//
//  FileViewController.h
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/25/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectViewController.h"

@class GLFile;
@class GLProject;

@interface FileViewController : UIViewController <ProjectViewController>

@property (nonatomic, strong) GLProject *project;
@property (nonatomic, strong) GLFile *file;

@end
