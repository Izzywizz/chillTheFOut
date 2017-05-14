//
//  HelpViewController.m
//  DataModelChill
//
//  Created by Izzy on 14/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

/*
 * Include the container view which has a TableViewController
 * Create the two IBActions: Twitter/ Facebook
 * Connect them to the soical functionality in order to promote the app.
 */

#import "HelpViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/CALayer.h>


@import Social;

@interface HelpViewController ()
@property (weak, nonatomic) IBOutlet UIButton *TwitterButton;
@property (weak, nonatomic) IBOutlet UIButton *FacebookButton;

@end


@implementation HelpViewController

#pragma mark - UIViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)TwitterButtonPressed:(id)sender {
    SLComposeViewController *twitterViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [twitterViewController setInitialText:@"Please Check out this awesome app! TW"];
    [self presentViewController:twitterViewController animated:YES completion:nil];
}

- (IBAction)FacebookButtonPressed:(id)sender {
    SLComposeViewController *facebookViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookViewController setInitialText:@"Please Check out this awesome app! FB"];
    [self presentViewController:facebookViewController animated:YES completion:nil];
}

- (IBAction)BackButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
