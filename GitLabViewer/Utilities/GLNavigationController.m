//
//  GLNavigationController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/13/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLNavigationController.h"

@interface GLNavigationController ()

@end

@implementation GLNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
