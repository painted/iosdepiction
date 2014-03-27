//
//  PTDMessagesTableViewController.m
//  Depiction
//
//  Created by Will Allen on 26/03/2014.
//  Copyright (c) 2014 Painted Ltd. All rights reserved.
//

#import "PTDMessagesTableViewController.h"

// import a pod we use angled brackets because it is
// extrenal to our project (we didn't write it)
# import <AFNetworking/UIImageView+AFNetworking.h>

// import a category to shrink the large image this is now part of the project so use ""
#import "UIImage+Resize.h"

@interface PTDMessagesTableViewController ()

@end

@implementation PTDMessagesTableViewController

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
    
    // we can use the selectedUser property to
    // set the title accordingly
    
    self.title = self.selectedUser.username;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // go and fetch the messages
    [self loadData];
    
}

// we will be using thismethod to retreive messages
// from the server
- (void) loadData{
    
    // Give me all the messages where:
    //I am the sender and they are the recipient
    // or
    // They are the sender and I am the recipient
    
    // check out parse.com/docs/ios_guide#queries-basic/iOS this has
    // told us that to query a custom class use this:
    PFQuery *senderQuery = [PFQuery queryWithClassName:@"Message"];
    
    // I am the sender
    [senderQuery whereKey:@"sender" equalTo:[PFUser currentUser]];
    
    // and they are the recipient as selectedUser was set in message controller
    // you can use self.selectedUser
    [senderQuery whereKey:@"recipient" equalTo:self.selectedUser];
    
    
    PFQuery *recipientQuery = [PFQuery queryWithClassName:@"Message"];
    
    // The sender is the selecteduser
    [recipientQuery whereKey:@"sender" equalTo:self.selectedUser];
    
    // I am the recipient
    [recipientQuery whereKey:@"recipient" equalTo:[PFUser currentUser]];
    
    /* 
     to make an array we can use [[NSArray alloc] initWithObjects:...]
     To save time apple has added a shorthand method
     @[object1,object2....]
     */
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[senderQuery,recipientQuery]];

    // show the latest method on the top
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        // we must create a mutable array (NSMutableArray)
        // for the NSArraty that we've been given by Parse
        // otherwise we cannot add more messages to it
        if (!error){
            
            self.messages = [objects mutableCopy];
            
            //cause the table to ask us for number of sections
            //number of rows in each section how to display the cell
            [self.tableView reloadData];
            
        }
  
        else    {             // output a description of the error to the console
            NSLog(@"Error loading messages: %@", [error localizedDescription]);
        
        // get a reference to a string representeing the title of the alert
        NSString *title = NSLocalizedString(@"Error", nil);
        
        // get a string for the message, using the error message
        NSString *message = [NSString stringWithFormat:@"Error logging in: %@", [error localizedDescription]];
        
        // create a string for the cancel button title
        NSString *cancelTitle = NSLocalizedString(@"Cancel", nil);
        
        //create an alert view containing the text that we've defined above.
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles: nil];
        
        // put the alert view on screen
        [alertView show];}
   

        
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.messages count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    // set the label on the cell so we can verify that it's working
    // the following line cell.text.... will be commented out 
    // cell.textLabel.text = @"message!!";
    
    //get a reference to the message object represented by
    // this cell
    //
    // self.messages[indePath.row]
    //
    // is equivalent to:
    //
    //[self.messages objectAtIndex:indexPath.row]
    //
    PFObject *message = self.messages [indexPath.row];
    
    // get a reference to the image view in the cell
    
    UIImageView *imageView= (UIImageView *)[cell viewWithTag:1];
    
    // get a reference to the label in the label in the cell
    UILabel *label= (UILabel *)[cell viewWithTag:2];
    
    /* get a reference to the image file so we can
    use its URL to download the image
     [message objectForKey:@"image"]
     can be shortened to 
     message [@"image"]
     */
    
    PFFile *file= [message objectForKey:@"image"];
    
    // convert the file URL (which is an NSString to
    // an NSURL which is used when loading from the web
    
    NSURL *imageURL = [NSURL URLWithString:file.url];
    
    // set the image - this will go off and download it for us
    [imageView setImageWithURL:imageURL];
    
    // get a reference to the sender  of the message
    // this is a PFUser object
    PFUser *sender = message [@"sender"];
    
    // work out if the sender is the same as current user or not
    
    if ([sender.objectId isEqualToString:[PFUser currentUser].objectId]){
        
        // it is sent by me
        label.text = NSLocalizedString(@"Sent by me",nil);
        
    }
    else{
        
        // it is sent by the selected user
        label.text = [NSString stringWithFormat:NSLocalizedString(@"Sent by %@", nil),self.selectedUser.username];
        
    }
    
    
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

- (IBAction)cameraButtonPressed:(UIBarButtonItem*)sender {
    
    NSLog(@"camera pressed!!");
 
    // create an instance of the camera view controller
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    // set the type of media we want to receive as a camera image
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // or set the type of media we want to receive as a photo from library
    //picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    
    // set the delegate - we want to do this because we want to
    // get an image back or nothing at all (cancel)
    // set the delegate to ourselves as we want to be told if it happened or not.
    
    picker.delegate = self;
    
    // present the view controller
    [self presentViewController:picker animated:YES completion:nil];

    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSLog(@"image taken");


    /*
     [info objectForKey:UIImagePickerControllerOriginalImage];
     
     is equilavent to:
     
     info[UIImagePickerControllerOriginalImage];
     
     */
   
    // get a reference to image by asking the dictionary
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // create a new message. We must ensure that we use exactly the same
    // class name as used in Parse
    PFObject *newMessage = [PFObject objectWithClassName:@"Message"];
    
    // ensure that the logged in user is the sender
    newMessage [@"sender"] = [PFUser currentUser];
    
    // set a recipient accordingly
    newMessage [@"recipient"] = self.selectedUser;
    
    // set the ACL which is the security settings Access Control
    
    PFACL *accessControl = [PFACL ACL];
    
    // set public read access to no
    [accessControl setPublicReadAccess:NO];
    
    // set read access for the current user
    [accessControl setReadAccess:YES forUser:[PFUser currentUser]];
    
    // set write access for the current user
    [accessControl setWriteAccess:YES forUser:[PFUser currentUser]];
    
    // set the read access for the recipient
    [accessControl setReadAccess:YES forUser:self.selectedUser];
    
    // assign the access control to the new message
    newMessage.ACL = accessControl;
    
    // 1) Resize the image
    // 2) JPEG compress the small image at 60%
    NSData *imageData = UIImageJPEGRepresentation([image resizedImage:CGSizeMake(640.0, 1136.0)], 0.6f);
    
    // create a PFFile instance using the JPEG data
    PFFile *imageFile = [PFFile fileWithName:@"image.jpg" data:imageData];
    
    
    newMessage[@"image"] = imageFile;
    
    // we can now upload this to the Parse server
    
    [newMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
     
        if (error) {
            
            NSLog(@"Error Sending message; %@", [error localizedDescription]);
            
        }

        else
        {
            
            [self.messages insertObject:newMessage atIndex:0];
            
            // insert this message into the tableview
            // .....  with animation!!!
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }
    }];
    
    
    //we are responsible for getting the camera off the screen
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    NSLog(@"Image Cancelled");
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}
    
    








@end





