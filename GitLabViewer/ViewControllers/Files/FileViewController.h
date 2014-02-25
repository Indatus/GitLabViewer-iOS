//
//  FileViewController.h
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/25/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLFile;
@class GLProject;

@interface FileViewController : UIViewController

@property (nonatomic, strong) GLProject *project;
@property (nonatomic, strong) GLFile *file;

@end
