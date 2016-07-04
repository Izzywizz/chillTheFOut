//
//  Data.h
//  DataModelChill
//
//  Created by Izzy on 10/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "AddNewMeditationTableViewController.h"

@class MeditationPack;
@class MeditationItem;
@class AddNewMeditationTableViewController;

@interface Data : NSObject<SKProductsRequestDelegate>

@property NSArray *quoteArray;
@property NSMutableArray *meditationPackArray;
@property MeditationPack *selectedMeditationPack;
@property MeditationItem *selectedMeditationItem;


//properties for add new med pack from network
@property(nonatomic, strong) NSMutableArray *productIdentifierList;
@property(nonatomic, strong) NSMutableArray *productDetailsList;

@property(nonatomic, strong) AddNewMeditationTableViewController *addNewPack;
@property SKProduct *selectedProduct;


+(Data *)sharedInstance;
-(void) setup;
-(void) QuoteSetup;

//Downloading datta
-(void) loadNetworkPacks;
-(void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response NS_AVAILABLE_IOS(3_0);
-(void) processDownload:(SKDownload*)download;



@end
