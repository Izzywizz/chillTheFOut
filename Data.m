//
//  Data.m
//  DataModelChill
//
//  Created by Izzy on 10/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

/*
 Singleton Pattern meaning that the data is shared across the App or only one instance is available for it
 This allows the creation of the meditation packs as the data is constant
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
    for (short itemCount = 4; itemCount <= 5; itemCount++) {
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
