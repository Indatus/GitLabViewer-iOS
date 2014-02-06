//
//  ProjectsCell.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/6/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "ProjectsCell.h"
#import <GLProject.h>

@interface ProjectsCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblLastActivity;

@end

@implementation ProjectsCell

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

- (void)setProject:(GLProject *)project
{
    if (_project != project) {
        _project = project;
    }
    
    _lblName.text = project.nameWithNamespace;
    _lblDescription.text = project.description;
    _lblLastActivity.text = @"Fixme because I don't work properly"; // TODO: fix this
}

@end
