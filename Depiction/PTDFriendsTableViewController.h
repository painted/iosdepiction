//
//  PTDFriendsTableViewController.h
//  Depiction
//
//  Created by Will Allen on 26/03/2014.
//  Copyright (c) 2014 Painted Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


// import the login controller's header file
// we must do this to adopt the protocol
#import "PTDLoginTableViewController.h"


@interface PTDFriendsTableViewController : UITableViewController <PTDLoginTableViewControllerDelegate>

// add an array property to store the friends list
@property NSArray *friends;



@end
