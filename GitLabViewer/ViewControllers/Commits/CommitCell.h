//
//  CommitCell.h
//  GitLabViewer
//
//  Created by Jon Staff on 2/25/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommitCell : UITableViewCell

- (void)setUpWithCommit:(GLCommit *)commit;

@end