//
//  MergeRequestCell.m
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/7/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "MergeRequestCell.h"
#import "Constants.h"

@interface MergeRequestCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSourceDestination;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthorName;

@end

@implementation MergeRequestCell

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

- (void)setUpWithMergeRequest:(GLMergeRequest *)mergeRequest
{
    _lblTitle.text = mergeRequest.title;
    _lblSourceDestination.text = [NSString stringWithFormat:@"%@ > %@", mergeRequest.sourceBranch, mergeRequest.targetBranch];
    _lblAuthorName.text = mergeRequest.author.name;
}

@end