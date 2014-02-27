//
//  ProjectViewController.h
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/27/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GLProject;

@protocol ProjectViewController <NSObject>

- (void)setProject:(GLProject *)project;
- (GLProject *)project;

@end
