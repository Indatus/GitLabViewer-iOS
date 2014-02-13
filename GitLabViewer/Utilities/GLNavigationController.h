//
//  GLNavigationController.h
//  GitLabViewer
//
//  Created by Jon Staff on 2/13/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLNavigationController : UINavigationController

@property (nonatomic, strong) GLProject *project;
@property (nonatomic, strong) GLBranch *branch;

@end
