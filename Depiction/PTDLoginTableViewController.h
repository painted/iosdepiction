//
//  PTDLoginTableViewController.h
//  Depiction
//
//  Created by Will Allen on 28/03/2014.
//  Copyright (c) 2014 Painted Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


// declare the protocol that will be used to inform another object
// when login has been successful

@protocol PTDLoginTableViewControllerDelegate;

@interface PTDLoginTableViewController : UITableViewController


// add two properties so that we can access the
// text fields  in our controller user 'self.userNameTextField...'
// we use the 'IBOutlet' keyword so we can connect them in the storyboard
@property IBOutlet UITextField *usernameTextField;
@property IBOutlet UITextField *passwordTextField;

@property (nonatomic, weak) id <PTDLoginTableViewControllerDelegate> delegate;

@end

// define the means by which it will inform another object
// that the login has been successful
@protocol PTDLoginTableViewControllerDelegate <NSObject>

// we only need one method, since we will only be dismissing this
// controller if successful
- (void)loginTableViewControllerDidLogin: (UITableViewController *)controller;

@end



