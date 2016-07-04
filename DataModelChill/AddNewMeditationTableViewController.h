//
//  AddNewMeditationTableViewController.h
//  DataModelChill
//
//  Created by Izzy on 15/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface AddNewMeditationTableViewController : UITableViewController<SKPaymentTransactionObserver>

@property (strong, nonatomic) IBOutlet UITableView *productDisplayTableView;


@end
