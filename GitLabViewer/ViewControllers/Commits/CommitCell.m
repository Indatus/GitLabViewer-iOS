//
//  CommitCell.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/25/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "CommitCell.h"

@implementation CommitCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
