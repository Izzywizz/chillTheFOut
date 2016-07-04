//
//  QuoteViewController.m
//  DataModelChill
//
//  Created by Izzy on 14/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "QuoteViewController.h"
#import "Data.h"

@interface QuoteViewController ()
@property (weak, nonatomic) IBOutlet UIButton *SkipQuoteButton;
@property (weak, nonatomic) IBOutlet UITextView *QuoteTextView;
@property NSArray *dataArray;

@end

@implementation QuoteViewController

#pragma mark - UITableView

-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [[Data sharedInstance] QuoteSetup];
    [self randomQuote];
    [self fiveSecondDelayView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewMethods

-(void)moveToNextView
{
    [self performSegueWithIdentifier:@"GoToMainMenu" sender:self];
}

-(void)fiveSecondDelayView
{
    [self performSelector:@selector(moveToNextView) withObject:nil afterDelay:5.0f];

}

#pragma mark - IBAction

//Transparent button overlayed over quote
- (IBAction)SkipQuoteButtonPressed:(id)sender {
    [self moveToNextView];
    [NSObject cancelPreviousPerformRequestsWithTarget:self]; //prevents the fiveSeconddelay method being called.
}

#pragma mark - RandomQuoteMethod

-(void) randomQuote
{
    //Store the quotes from the plist into an array
    _dataArray = [NSArray arrayWithArray:[Data sharedInstance].quoteArray];
    
    if ([_dataArray count] == 0) {
        NSLog(@"plist empty!");
    } else {
        NSUInteger randomIndex = arc4random() % [_dataArray count];//randomly selects a quote from an array
        _QuoteTextView.text = [_dataArray objectAtIndex:randomIndex];
    }
}

@end
