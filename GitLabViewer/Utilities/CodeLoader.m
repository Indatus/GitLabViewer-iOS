//
//  CodeLoader.m
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/28/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "CodeLoader.h"
#import <GLFile.h>

@implementation CodeLoader

static NSString *syntaxHighlighterDirectory;
static NSString *template;

+ (void)load
{
    NSString *url = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
    syntaxHighlighterDirectory = [url stringByDeletingLastPathComponent];
    template = [NSString stringWithContentsOfFile:url encoding:NSUTF8StringEncoding error:nil];
}

+ (NSString *)createHtmlFor:(GLFile *)file withContent:(NSString *)content
{
    NSString *htmlName = [NSString stringWithFormat:@"%@.html", [file nameWithoutExtension]];
    NSString *filePath = [syntaxHighlighterDirectory stringByAppendingPathComponent:htmlName];
    NSString *html = [template copy];
    NSString *extension = [[file.name componentsSeparatedByString:@"."] lastObject];
    NSString *generateCodeBlock = [self generateCodeBlockForFileExtension:extension andContent:content];
    
    html = [NSString stringWithFormat:html, generateCodeBlock];
    [html writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];

    return filePath;
}

+ (NSString *)generateCodeBlockForFileExtension:(NSString *)extension andContent:(NSString *)content
{
    return [NSString stringWithFormat:@"<pre class=\"brush: %@\"%@</pre>", extension, [self textToHtml:content]];
}

+ (NSString*)textToHtml:(NSString*)htmlString {
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&"  withString:@"&amp;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<"  withString:@"&lt;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@">"  withString:@"&gt;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"""" withString:@"&quot;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"'"  withString:@"&#039;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    return htmlString;
}

@end
