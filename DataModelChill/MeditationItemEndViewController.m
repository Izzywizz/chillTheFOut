//
//  MeditationItemEndViewController.m
//  DataModelChill
//
//  Created by Izzy on 13/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

/*
 The congratulatiosn screens only occurs after the audio/ meditation item has finished, as the audio has been registered on the previous (Meditation Audio) is using a delegate
 Class also contains a social method which allows the posting of messges to FAcebook/ Twitter
 A custom back button had to be created which only navigates back to the main menu becuase the navigation controller is embedded within a difference screen of so it cant just pop back to main/parent controller
 */

#import "MeditationItemEndViewController.h"
#import "ViewController.h"
#import "MeditationItem.h"
#import "Data.h"

@import Social;

@interface MeditationItemEndViewController()

@property MeditationItem *item;
@property (weak, nonatomic) IBOutlet UITextView *CongratulationsText;
@property (weak, nonatomic) IBOutlet UIButton *FacebookButton;
@property (weak, nonatomic) IBOutlet UIButton *TwitterButton;

@end

@implementation MeditationItemEndViewController

#pragma mark - UIViewController

-(void)viewWillAppear:(BOOL)animated
{
    _item = [Data sharedInstance].selectedMeditationItem;
    [self setCongratulationsText];
    [self setNavigationItemTitle];
}

-(void)setNavigationItemTitle
{
    [_CongratulationsText setSelectable:NO];
    self.navigationItem.title = _item.meditaitonItemTitle;
}


#pragma mark - UITextView

-(void) setCongratulationsText
{
    _CongratulationsText.text = _item.meditationItemCongratulationsText;
}


#pragma mark - IBAction

- (IBAction)FacebookButtonPressed:(id)sender {
    SLComposeViewController *facebookViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookViewController setInitialText:@"I feel Motivated"];
    [self presentViewController:facebookViewController animated:YES completion:nil];
}

- (IBAction)TwitterButtonPressed:(id)sender {
    SLComposeViewController *twitterViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [twitterViewController setInitialText:@"I Feel Motivated Twi"];
    [self presentViewController:twitterViewController animated:YES completion:nil];
}

- (IBAction)BackButtonPressed:(id)sender {
    //Iterate through the view controllers!, find the main menu view controller and pop that on to the stack
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[ViewController class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
            
            break;
        }
    }
}

@end
