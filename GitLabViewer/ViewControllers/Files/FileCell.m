//
//  FileCell.m
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/24/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "FileCell.h"
#import <GLFile.h>

@interface FileCell ()

@property (weak, nonatomic) IBOutlet UIImageView *fileTypeImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shaLabel;

@end

@implementation FileCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithFile:(GLFile *)file
{
    switch (file.type) {
        case GLFileTypeBlob:
            [_fileTypeImage setImage:[UIImage imageNamed:@"cell-file"]];
            break;
            
        case GLFileTypeTree:
            [_fileTypeImage setImage:[UIImage imageNamed:@"cell-folder"]];
            break;
    }
    
    _nameLabel.text = file.name;
    _shaLabel.text = file.fileId;
}

@end
