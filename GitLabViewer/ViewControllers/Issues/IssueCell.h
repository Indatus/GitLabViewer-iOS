//
//  IssueCell.h
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/7/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueCell : UITableViewCell

- (void)setupWithIssue:(GLIssue *)issue;

@end
