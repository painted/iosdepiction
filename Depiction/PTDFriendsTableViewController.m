//
//  PTDFriendsTableViewController.m
//  Depiction
//
//  Created by Will Allen on 26/03/2014.
//  Copyright (c) 2014 Painted Ltd. All rights reserved.
//

#import "PTDFriendsTableViewController.h"

// impor the header file for the messages controller
// we need this in order to set the 'selectedUser' property
// in prepareForSegue' method

#import "PTDMessagesTableViewController.h"

@interface PTDFriendsTableViewController ()

@end

@implementation PTDFriendsTableViewController

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
    
    // use NSLocalizedString () macro to allow us to use translated
    // strings if we have them
    self.title = NSLocalizedString(@"Friends", @"title of friends controller");

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }

- (void)viewDidAppear:(BOOL)animated {
    
    if (![PFUser currentUser]) {
        
        // there is no current user....
        // present a login dialog?
        
        [self performSegueWithIdentifier:@"ShowLogin" sender:nil];
        
        
        /*  This will no longer be used as this will now be done on the login screen
         [PFUser logInWithUsernameInBackground:@"username" password:@"password" block:^(PFUser *user, NSError *error) {
         
         if (!error) {
         // if no error, we can assume that we are now logged in
         
         // we can go ahead and load data
         [self loadData];
         
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
         */
        
        
    }
    
    // if the user is already logged in it will also load data
    else {
        [self loadData];
    }
    
}

// add a method that will be used to load the list of friends
-(void) loadData{
    
    // creat a new query which will be used to get a list of friends
    // excluding our user
    PFQuery *query = [PFUser query];
    
    // get a reference to the current user
    // this will not be nill, since we've checked already viewDid Appear
    // and logged in
    PFUser *currentUser = [PFUser currentUser];
    
    // we do that by filtering out our username
    // The server i.e. parse will interate through
    // each item in the database and check that the 'username'
    // field is not equal to the value that we're giving below
    // i.e. the current user's username.
    
    [query whereKey:@"username" notEqualTo:currentUser.username];
    
    // if we wnat to we can order by any key field in the database.
    // i.e. any field in the parse database.
    [query orderByDescending:@"username"];
    
    // go to the Parse web server and return a list of users matching our
    // query
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
     
    
        if (!error) {
            // set the array of  user objects from Parse as our friend array
            // we can then access it using self.friends throughout this file
            self.friends = objects;
            [self.tableView reloadData];
            
        }
        
        else {
            
            // output a description of the error to the console
            NSLog(@"Error finding friends: %@", [error localizedDescription]);
            
        }
    }];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // We only have one section in this app
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // This will count the number of cells in the array friends
    return [self.friends count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This cell identifier needs to match exactly (including case) the cell identifier
    // used in the storyboard
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    // get a reference to the user for this row in the table
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    
    // set the label for the cell as the user's username
    // this is an NSString property and so can be used
    // with the UILabel 'text' property
    cell.textLabel.text = user.username;
    
    return cell;
}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // confirm that we are performing the correct segue
    // use 'isEqualtoString' to companre text
    // ensure that your storyboard contains the same identifier
    // for segue (case sensitive)
    
    if ([segue.identifier isEqualToString:@"ShowMessages"]){
        
        // get a reference to the messages table controller
        // that is about to be pushed onto the screen

        PTDMessagesTableViewController *messagesController = [segue destinationViewController];
        
        // 'fixing ' the class of the sender object to UITableViewCell
        // converting  'id', which means any class, to a specific class
        
        UITableViewCell *cell = sender;
        
        // ask the tableview for the indexpath for the selected cell
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        
        // get the user at the conrrect index of the array (the row that was selected)
        PFUser *user = [self.friends objectAtIndex:indexPath.row];
        
        // set the user on the new view controller as the user that has been selected
        messagesController.selectedUser = user;
        
        
    }
    
    else if ([segue.identifier isEqualToString:@"ShowLogin"]){
        
        // in this case (you can see in the storyboard) segue is
        // connected to a navigation controller
        UINavigationController *navController = [segue destinationViewController];
        
        //get a reference to the login controller, which is just the
        // first (top) view controller in the navigation stack
        PTDLoginTableViewController *loginController = (PTDLoginTableViewController *)[navController topViewController];
        
        // ensure that we (the friends controller) are notified when
        // login is complete
        loginController.delegate = self;
        
        
    }
    
}

- (void) loginTableViewControllerDidLogin:(UITableViewController *)controller{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}




@end















