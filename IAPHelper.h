//
//  IAPHelper.h
//  Chill The F Out
//
//  Created by Izzy on 29/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "MeditationPack.h"
#import "NetworkData.h"
#import "Data.h"


@interface IAPHelper : NSObject

- (void) processDownload:(SKDownload*)download;

@end
