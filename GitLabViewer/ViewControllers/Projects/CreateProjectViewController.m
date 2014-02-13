//
//  CreateProjectViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/11/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "CreateProjectViewController.h"
#import "UIAlertView+Blocks.h"

@interface CreateProjectViewController ()
{
    UIGestureRecognizer *_cancelKeyboardGesture;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *inputTitle;
@property (weak, nonatomic) IBOutlet UITextField *inputDescription;
@property (weak, nonatomic) IBOutlet UISwitch *switchIssues;
@property (weak, nonatomic) IBOutlet UISwitch *switchWall;
@property (weak, nonatomic) IBOutlet UISwitch *switchMergeRequests;
@property (weak, nonatomic) IBOutlet UISwitch *switchWiki;
@property (weak, nonatomic) IBOutlet UISwitch *switchSnippets;
@property (weak, nonatomic) IBOutlet UISwitch *switchPublic;

@end

@implementation CreateProjectViewController

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
    
    self.title = @"Create Project";
    
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

- (IBAction)btnCreateClicked:(id)sender
{
    NSString *title = _inputTitle.text;
    
    if (title.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You must specify at least a title."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Create Project?"
                                                        message:@"Please verify that all the information is correct."
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Create", nil];
        [alert showWithCompletion:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex != [alertView cancelButtonIndex]) {
                GLProject *project = [GLProject new];
                project.name = title;
                project.projectDescription = _inputDescription.text;
                project.issuesEnabled = _switchIssues.isOn;
                project.wallEnabled = _switchWall.isOn;
                project.mergeRequestsEnabled = _switchMergeRequests.isOn;
                project.snippetsEnabled = _switchSnippets.isOn;
                project.publicProject = _switchPublic.isOn;
                
                [[GLGitlabApi sharedInstance] createProject:project success:^(id responseObject) {
                    NSLog(@"Project created successfully!");
                    [self dismissViewControllerAnimated:YES completion:nil];
                } failure:^(NSError *error) {
                    NSLog(@"Project creation failed...");
                    UIAlertView *failedAlert = [[UIAlertView alloc] initWithTitle:@"Creation Failed"
                                                                          message:@"Failed to create this project - please try again."
                                                                         delegate:nil
                                                                cancelButtonTitle:@"OK"
                                                                otherButtonTitles:nil];
                    [failedAlert show];
                }];
            }
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
