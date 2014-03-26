//
//  PTDMessagesTableViewController.h
//  Depiction
//
//  Created by Will Allen on 26/03/2014.
//  Copyright (c) 2014 Painted Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTDMessagesTableViewController : UITableViewController


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