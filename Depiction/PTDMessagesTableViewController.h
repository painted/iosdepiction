//
//  PTDMessagesTableViewController.h
//  Depiction
//
//  Created by Will Allen on 26/03/2014.
//  Copyright (c) 2014 Painted Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


// adopt the two necessary protocols to use the camera
@interface PTDMessagesTableViewController : UITableViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

// we need to store our messages to and from our selected user.
// it is mutable as the app can now add more messages (items)
@property (nonatomic, strong) NSMutableArray *messages;

// declare a property to keep a reference to the user
// that has been pressed on
// we can use this to set the title using its username, for example
@property (nonatomic, strong) PFUser *selectedUser;

// we add 'nonatomic' because a) it's quicker, but more
// importantly, b) we won;t be accessing it simultaneously from
// different parts in our app

// we use strong because we want the object to stay around
// for the lifetime of this object (the controller)

@end
