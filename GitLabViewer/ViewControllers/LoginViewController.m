//
//  LoginViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/4/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "LoginViewController.h"
#import "ProjectsViewController.h"
#import "UserPreferences.h"
#import <GLGitlabApi+Session.h>
#import <GLGitlabApi+Projects.h>

@interface LoginViewController ()
{
    UserPreferences *_userPrefs;
}

@property (weak, nonatomic) IBOutlet UITextField *inputServerAddress;
@property (weak, nonatomic) IBOutlet UITextField *inputUsername;
@property (weak, nonatomic) IBOutlet UITextField *inputPassword;

@end

@implementation LoginViewController

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
    // Do any additional setup after loading the view from its nib.
    
    _userPrefs = [UserPreferences sharedInstance];
    _inputServerAddress.text = _userPrefs.hostname;
    _inputUsername.text = _userPrefs.username;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Custom IBActions

- (IBAction)btnSignInClicked:(id)sender
{
    NSString *serverAddress = _inputServerAddress.text;
    NSString *username = _inputUsername.text;
    NSString *password = _inputPassword.text;
    
    if (serverAddress.length < 1 || username.length < 1 || password.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please fill out all the fields."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [[GLGitlabApi sharedInstance] loginToHost:serverAddress
                                     username:username
                                     password:password
                                      success:^(GLUser *user) {
                                          NSLog(@"The user is: %@", user);
                                          
                                          _userPrefs.hostname = serverAddress;
                                          _userPrefs.username = username;
                                          _userPrefs.password = password;
                                          _userPrefs.loggedIn = YES;
                                          _userPrefs.user = user;
                                          
                                          [[GLGitlabApi sharedInstance] getUsersProjectsSuccess:^(NSArray *projects) {
                                              NSLog(@"Projects: %@", projects);
                                              ((ProjectsViewController *) self.presentingViewController.childViewControllers[0]).projects = [projects copy];
                                              [self dismissViewControllerAnimated:YES completion:nil];
                                          }
                                                                                      failure:^(NSError *error) {
                                                                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                                                          message:@"There was an issue fetching projects. Please sign in again."
                                                                                                                                         delegate:nil
                                                                                                                                cancelButtonTitle:@"OK"
                                                                                                                                otherButtonTitles:nil];
                                                                                          [alert show];
                                                                                      }];

    }
                                      failure:^(NSError *error) {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                               message:@"There was an issue logging in. Please check the credentials and try again."
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil];
                               [alert show];
    }];
}


#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self btnSignInClicked:nil];
    [textField resignFirstResponder];
    return YES;
}

@end