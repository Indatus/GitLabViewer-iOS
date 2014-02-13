//
//  CreateMergeRequestViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/13/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "CreateMergeRequestViewController.h"
#import "UIAlertView+Blocks.h"
#import "GLNavigationController.h"

@interface CreateMergeRequestViewController ()
{
    UIGestureRecognizer *_cancelKeyboardGesture;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *inputTitle;
@property (weak, nonatomic) IBOutlet UITextView *inputDescription;
@property (weak, nonatomic) IBOutlet UITextField *inputSourceBranch;
@property (weak, nonatomic) IBOutlet UITextField *inputTargetBranch;
@property (weak, nonatomic) IBOutlet UITextField *inputAssignee;

@end

@implementation CreateMergeRequestViewController

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

    self.title = @"Create Merge Request";
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelModal)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    [self addKeyboardObservers];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Custom IBActions

- (IBAction)btnSubmitMergeRequestClicked:(id)sender
{
    NSString *title = _inputTitle.text;
    NSString *sourceBranch = _inputSourceBranch.text;
    NSString *targetBranch = _inputTargetBranch.text;
    
    if (title.length < 1 || sourceBranch.length < 1 || targetBranch.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You must specify at least a title, the source branch, and the target branch."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Merge Request?"
                                                        message:@"Please verify that all the information is correct."
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Submit", nil];
        [alert showWithCompletion:^(UIAlertView *alertView, NSInteger buttonIndex) {
            GLMergeRequest *merge = [GLMergeRequest new];
            merge.projectId = ((GLNavigationController *) self.navigationController).project.projectId;
            merge.title = title;
            merge.sourceBranch = sourceBranch;
            merge.targetBranch = targetBranch;
            
            [[GLGitlabApi sharedInstance] createMergeRequest:merge withSuccessBlock:^(id responseObject) {
                NSLog(@"Merge request created successfully!");
            } andFailureBlock:^(NSError *error) {
                NSLog(@"Merge request creation failed...");
            }];
        }];
    }
    
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
