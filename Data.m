//
//  Data.m
//  DataModelChill
//
//  Created by Izzy on 10/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

/*
 Singleton Pattern meaning that the data is shared across the App or only one instance is available for it
 This allows the creation of the meditation packs/ itesms as the data is constantly accessible through the pattern.
 The class also houses the product catalouge list for unique ID for the in app purchases, it iterates through a list and genrates them.
 These are then passed on to the process download Class (Network Data) which hanldes the files actualy downloaded
 
 Since the product ID even for the IAP are unqiue when I asked Andy to delete 1-3 on itunes connect it was a mistake, as the they cant be used again, so we must start from 4 (hence the itemCount = 4)
 Please take into account that a short was used
 We also need to see the effect of increasing the number of itemCount will do to non existent packs on itunes connect
 */


#import "Data.h"
#import "MeditationPackDataSource.h"
#import "MeditationPack.h"
#import "IAPHelper.h"


@interface Data()

@property (nonatomic) NetworkData *store;
@property (nonatomic) IAPHelper *helper;
@property (nonatomic) NSFileManager *filemanager;

@end

@implementation Data

+ (Data *)sharedInstance {
    static Data *sharedMyData = nil;
    @synchronized(self) {
        if (sharedMyData == nil)
            sharedMyData = [[self alloc] init];
    }
    return sharedMyData;
}

-(void) setup
{
    MeditationPackDataSource *medPackDS = [MeditationPackDataSource new];
    _meditationPackArray = [[medPackDS meditationPackArray]mutableCopy];
   
}

-(void)QuoteSetup
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Quotes" ofType:@"plist"];
    _quoteArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
}


#pragma mark - StoreKit related methods

-(void) loadNetworkPacks
{
    
    _productDetailsList    = [[NSMutableArray alloc] init];
    _productIdentifierList = [[NSMutableArray alloc] init];
    
    [NSUserDefaults standardUserDefaults];
    
    //this part is not dynamic, you need to set the number of items/meditation packs available to buy
    for (short itemCount = 4; itemCount <= 15; itemCount++) {
        [_productIdentifierList addObject:[NSString stringWithFormat:@"com.reraisedesign.ChillTheFOut.MeditationPack%d", itemCount]];
    }
    
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:_productIdentifierList]];
    
    request.delegate = self;
    [request start];
    
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response NS_AVAILABLE_IOS(3_0)
{
    
    if(_productDetailsList != 0)
    {
        [_productDetailsList addObjectsFromArray: response.products];
        [_addNewPack.productDisplayTableView reloadData];
    } else  {
        NSLog(@"Products not found");
    }
}

#pragma mark - dataDownloadedFromStore

- (void) processDownload:(SKDownload*)download
{
    _helper = [[IAPHelper alloc] init];
    [_helper processDownload:download];
}

@end
