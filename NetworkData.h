//
//  PlistStore.h
//  Chill The F Out
//
//  Created by Izzy on 23/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "MeditationItem.h"
#import "MeditationPack.h"


@interface NetworkData : NSObject

@property (nonatomic) NSMutableArray *storeData;
@property (nonatomic) NSMutableDictionary *unpackDataDict;
@property (nonatomic) NSMutableArray *storeSongData;
@property (nonatomic) NSMutableArray *storeImageData;
@property (nonatomic) NSMutableArray *meditationItemArray;
@property (nonatomic) NSMutableSet *mainDataArray;
@property (nonatomic) NSString *medPackTitle;
@property (nonatomic) NSString *productID;

-(void) storeDataViaPlist: (NSString *)pathToPlist;
-(void) storeMp3Path: (NSString *)pathToMp3;
-(void) storeImagePath: (NSString *) pathToImages;

-(MeditationPack *) createMeditationPack;
-(void) stepThroughEachItem;
-(MeditationPack *) createMeditationPack: (NSDictionary *) dict;

@end
