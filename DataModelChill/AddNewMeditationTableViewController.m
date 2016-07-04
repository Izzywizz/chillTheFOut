//
//  AddNewMeditationTableViewController.m
//  DataModelChill
//
//  Created by Izzy on 15/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

/*
 */

#import "AddNewMeditationTableViewController.h"
#import "Data.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface AddNewMeditationTableViewController ()

@property NSMutableArray *productArray;
@property  AVAudioPlayer *audioPlayer;

@end

@implementation AddNewMeditationTableViewController

#pragma mark - UItableViewController

-(void) viewWillAppear:(BOOL)animated
{
    _productArray = [[NSMutableArray alloc]initWithArray:[Data sharedInstance].productDetailsList];
    //[self startup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[SKPaymentQueue defaultQueue]removeTransactionObserver:self];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - AlertViewController



#pragma mark - TableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    //return [_testArray count];
    
    return [_productArray count];
    //return [[Data sharedInstance].productDetailsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyCell" forIndexPath:indexPath];
    
    // Configure the cell...
    //cell.textLabel.text = [_testArray objectAtIndex:indexPath.row];
    
    SKProduct *thisProduct = [_productArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ - %@", thisProduct.localizedTitle, thisProduct.price]];
    
    //NSLog(@"Product title: %@" , thisProduct.localizedTitle);
    //NSLog(@"Product description: %@" , thisProduct.localizedDescription);
    //NSLog(@"Product price: %@" , thisProduct.price);
    //NSLog(@"Product id: %@" , thisProduct.productIdentifier);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //remove the selection animation
    if ([self canMakePurchases]) {
        
        [Data sharedInstance].selectedProduct = [_productArray objectAtIndex:indexPath.row];
        NSLog(@"%ld: ", (long)indexPath.row);
        NSLog(@"Product: %@ has been SELECTED!", [Data sharedInstance].selectedProduct.localizedTitle);
        SKPayment *payment = [SKPayment paymentWithProduct:[Data sharedInstance].selectedProduct];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];//register the delgate to ensure that the payment will be processed
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    
}

#pragma mark - IBActions


- (IBAction)BackButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)RestoreButtonPressed:(id)sender {
    NSLog(@"Purchases Restored!");
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

#pragma mark - SKPaymentTransactionObserver

- (BOOL)canMakePurchases
{
    return [SKPaymentQueue canMakePayments];
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    //NSLog(@"%@", transactions);
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState) {
                
            case SKPaymentTransactionStatePurchased:
            case SKPaymentTransactionStateRestored:
                if (transaction.downloads)
                {
                    [[SKPaymentQueue defaultQueue] startDownloads:transaction.downloads];
                    break;
                    //start downloading the medidation pack! if it has one, if not just unlok the feature!
                }
                else
                {
                    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                }
                break;
                
            case SKPaymentTransactionStateFailed:
                // NOT SHOWN: tell the user about the failure (could just be a cancel) (implement this!)
                [[SKPaymentQueue defaultQueue] cancelDownloads:transaction.downloads];
                NSLog(@"Transaction Failed");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            default:
                break;
        }
    }
}


#pragma mark - DownloadMethods
- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray *)downloads;
{
    for (SKDownload *download in downloads) {
        
        
        if (download.downloadState == SKDownloadStateFinished)
        {
            [queue finishTransaction:download.transaction];
            [[Data sharedInstance] processDownload:download];
            
        }
        else if (download.downloadState == SKDownloadStateActive)
        {
            float progress = download.progress; // 0.0 -> 1.0
            NSLog(@"Progress:%f", progress);
            
        }
        else if (download.downloadState == SKDownloadStateWaiting)
        {
            NSLog(@"Download - Waiting");
        }
        else if (download.downloadState == SKDownloadStatePaused)
        {
            NSLog(@"Download - Paused");
        }
        else if (download.downloadState == SKDownloadStateCancelled)
        {
            NSLog(@"Download - Cancelled");
        }
        else if (download.downloadState == SKDownloadStateFailed)
        {
            NSLog(@"Download = Failed");
        }
        else
        {    // waiting, paused, failed, cancelled
            NSLog(@"Warn: not handled: %ld", (long)download.downloadState);
        }
    }
}
@end
