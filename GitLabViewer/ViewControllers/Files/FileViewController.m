//
//  FileViewController.m
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/25/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "FileViewController.h"
#import <GLFile.h>
#import <GLGitlabApi+Files.h>

@interface FileViewController ()

@end

@implementation FileViewController

- (void)fetchData
{
    [[GLGitlabApi sharedInstance] getFileContentFromProject:self.project.projectId
                                                        sha:_file.fileId
                                           withSuccessBlock:^(id responseObject) {
                                               NSLog(@"Response Object: %@", responseObject);
                                           }
                                            andFailureBlock:^(NSError *error) {
                                                NSLog(@"Failure: %@", error);
                                            } ];
}

@end
