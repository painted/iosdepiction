//
//  PTDFullScreenViewController.h
//  Depiction
//
//  Created by Will Allen on 28/03/2014.
//  Copyright (c) 2014 Painted Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTDFullScreenViewController : UIViewController


// define a property to store the image to be displayed

@property (nonatomic, strong) UIImage *image;


// define a property to connect to the storyboard for the large image
@property IBOutlet UIImageView *imageView;


@end
