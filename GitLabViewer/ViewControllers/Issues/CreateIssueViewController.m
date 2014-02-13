//
//  CreateIssueViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/13/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "CreateIssueViewController.h"

@interface CreateIssueViewController ()
{
    UIGestureRecognizer *_cancelKeyboardGesture;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation CreateIssueViewController

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
    
    self.title = @"Create Issue";
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelModal)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    [self addKeyboardObservers];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Custom Methods

- (void)cancelModal
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Keyboard methods

- (void)addKeyboardObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:self.view.window];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    _cancelKeyboardGesture = [UITapGestureRecognizer new];
    [_cancelKeyboardGesture addTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:_cancelKeyboardGesture];
    
    CGRect viewFrame = _scrollView.frame;
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    viewFrame.size.height -= keyboardSize.height;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height - 100); // the '100' is just an arbitrary value that seems to work well
    _scrollView.frame = viewFrame;
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    CGRect viewFrame = _scrollView.frame;
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    viewFrame.size.height += keyboardSize.height;
    _scrollView.frame = viewFrame;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height - 100); // the '100' is just an arbitrary value that seems to work well
}

- (void)dismissKeyboard
{
    [self.view endEditing:YES];
    
    if(_cancelKeyboardGesture) {
        [self.view removeGestureRecognizer:_cancelKeyboardGesture];
        _cancelKeyboardGesture = nil;
    }
}


@end
