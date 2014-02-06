//
//  LoginViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/4/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "LoginViewController.h"
#import <GLGitlab.h>

@interface LoginViewController ()

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
    
    [[GLGitlabApi sharedInstance] loginToHost:serverAddress
                          username:username
                          password:password
                           success:^(GLUser *user) {
                               NSLog(@"The user is: %@", user);
                               [self dismissViewControllerAnimated:YES completion:nil];
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

@end