//
//  SingleIssueViewController.h
//  GitLabViewer
//
//  Created by Jon Staff on 2/11/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLIssue;

@interface SingleIssueViewController : UIViewController

@property (nonatomic, strong) GLIssue *issue;

@end
