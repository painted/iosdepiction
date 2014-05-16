//
//  PTDFullScreenViewController.m
//  Depiction
//
//  Created by Will Allen on 28/03/2014.
//  Copyright (c) 2014 Painted Ltd. All rights reserved.
//

#import "PTDFullScreenViewController.h"

@interface PTDFullScreenViewController ()

@end

@implementation PTDFullScreenViewController

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
    // Do any additional setup after loading the view.
    
    // set the image view's image as the image that has been
    // passed to this controller in 'performSegueWithIdentifier'
    
    self.imageView.image = self.image;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(IBAction)tapDetected:(UITapGestureRecognizer *)sender{
    
    NSLog(@"Tapped!!!");
    
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    
}





@end
