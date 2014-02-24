//
//  FileCell.h
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/24/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLFile;

@interface FileCell : UITableViewCell

- (void)setupWithFile:(GLFile *)file;

@end
