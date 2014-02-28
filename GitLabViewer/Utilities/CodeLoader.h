//
//  CodeLoader.h
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/28/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GLFile;

@interface CodeLoader : NSObject

+ (NSString *)createHtmlFor:(GLFile *)file withContent:(NSString *)content;

@end
