//
//  PTDLoginTableViewController.m
//  Depiction
//
//  Created by Will Allen on 28/03/2014.
//  Copyright (c) 2014 Painted Ltd. All rights reserved.
//

#import "PTDLoginTableViewController.h"

@interface PTDLoginTableViewController ()

@end

@implementation PTDLoginTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set the title - we're only doing login at this moment
    self.title = NSLocalizedString(@"Login", nil);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // set the default mode when this screen appears (I've picked login)
    self.mode = PTDLoginModeLogin;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see if we are logging in or registering.
    
    if (self.mode == PTDLoginModeLogin) {
        return 2;
    }
    
    else {
        return 3;
        
    }
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Actions


// this method gets triggered when the login button is pressed
- (IBAction)loginPressed:(UIBarButtonItem *) sender{
    
    NSLog(@"login pressed!");
    
    NSString *username = self.usernameTextField.text;
    
    NSString *password = self.passwordTextField.text;
    
    NSString *confirmPassword = self.confirmPasswordTextField.text;
    
    
    // check if we are supposed to be logging in or registering
    
    if (self.mode == PTDLoginModeLogin) {
        
            // login using contents of the text fields instead of hard-coding
    // username
    // password
    //
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        
        if (!error) {
            // if no error, we can assume that we are now logged in
            
            // invoking the delegat method - telling the delegate object
            // that login is successful and it is safe to dismiss
            // this view controller
            
            [self.delegate loginTableViewControllerDidLogin:self];
            
        }
        else {
            
            // output a description of the error to the console
            NSLog(@"Error logging in: %@", [error localizedDescription]);
            
            // get a reference to a string representeing the title of the alert
            NSString *title = NSLocalizedString(@"Error", nil);
            
            // get a string for the message, using the error message
            NSString *message = [NSString stringWithFormat:@"Error logging in: %@", [error localizedDescription]];
            
            // create a string for the cancel button title
            NSString *cancelTitle = NSLocalizedString(@"Cancel", nil);
            
            //create an alert view containing the text that we've defined above.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles: nil];
            
            // put the alert view on screen
            [alertView show];
            
        }
        
        
    }];

        
    }
    
    else{
        
        // register
        
        if ([password isEqualToString:confirmPassword]) {
            
            // passwords match, register the user
            
            // create a new user
            PFUser *user = [PFUser user];
            
            //assign its username property as the contents
            // of the username text field
            user.username = username;
            
            // likewise for the password
            user.password = password;
            
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (!error) {
                    
                    // sign up is successful, this view controller can now be dismissed
                   [self.delegate loginTableViewControllerDidLogin:self];
                    
                    
                }
                else
                {
                    // sign up is not succesful, show an alert to the user
                    
                    
                }
                
                
            } ];
            
            
        } else {
            
            // passwords don't match, show alert to the user.  Set up a UIAlertView
            
        }
        
        
    }
    
    
    
    
}


// add a method that will be triggered when 'Already Registered'
// button is pressed.
// this will toggle the mode between 'login' and 'register'

-(IBAction)modeButtonPressed:(UIButton*)sender {

    NSLog(@"mode button pressed");
    
    
    // check which mode we are in when the button is pressed
    if (self.mode == PTDLoginModeLogin) {
        
        // change to the opposite mode
        self.mode = PTDLoginModeRegister;
        
        // set title for register mode
        self.title = NSLocalizedString(@"Register", nil);
        
        // set tittle on the button according to the current mode
        [self.modeButton setTitle:NSLocalizedString(@"Already Registered?", nil) forState:UIControlStateNormal];
        
        // create an index path represeneting the row that will animate in
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        
        // perform the animation
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        
    } else {
        self.mode = PTDLoginModeLogin;
        
        // set title for register mode
        self.title = NSLocalizedString(@"Login  ", nil);
        
        // set tittle on the button according to the current mode
        [self.modeButton setTitle:NSLocalizedString(@"Not Registered?", nil) forState:UIControlStateNormal];
        
        // create an index path represeneting the row that will animate out
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        
        // perform the animation
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        
    }
    


}

@end






