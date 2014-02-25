//
//  CommitCell.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/25/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "CommitCell.h"
#import "Constants.h"

@interface CommitCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblSha;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthor;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end

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

- (void)setUpWithCommit:(GLCommit *)commit;
{
    NSDateFormatter *formatter = [Constants standardFormatter];

    _lblSha.text = commit.sha;
    _lblMessage.text = commit.title;
    _lblAuthor.text = commit.authorName;
    _lblDate.text = [formatter stringFromDate:commit.createdAt];
}

@end