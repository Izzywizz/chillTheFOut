//
//  PlistStore.m
//  Chill The F Out
//
//  Created by Izzy on 23/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "NetworkData.h"
#import <Foundation/Foundation.h>

@interface NetworkData()

@property (nonatomic) NSMutableArray *savedItem;

@end

@implementation NetworkData

//Intial setup/ intilisation of arrays that will be used throughout class
-(id)init
{
    self = [super init];
    if (self) {
        _storeSongData = [[NSMutableArray alloc] init];
        _storeImageData = [[NSMutableArray alloc] init];
        _storeData = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - DataSotrage
-(void) storeDataViaPlist: (NSString *)pathToPlist;
{
    //_unpackDataDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pathToPlist];
    [_storeData addObject:pathToPlist];
}

-(void) storeMp3Path: (NSString *)pathToMp3
{
    [_storeSongData addObject:pathToMp3];
}

-(void) storeImagePath: (NSString *) pathToImages
{
    [_storeImageData addObject:pathToImages];
}

#pragma mark - SavedMedtiationsMethods

-(MeditationPack *) createMeditationPack: (NSDictionary *) dict;
{
    //NSLog(@"internal dictionary: %@", dict);
    MeditationPack *pack = [[MeditationPack alloc] init];
    pack.meditationPackID = 0;
    pack.meditationPackTitle = [dict valueForKey:@"Title"];
    pack.meditiationPackImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[dict valueForKey:@"Image"]]];
    
    NSMutableArray *itemsArray = [NSMutableArray new];
    itemsArray = [dict valueForKey:@"itemsArray"];
    pack.meditationItemsArray = [self createItems:itemsArray];
   // NSLog(@"Interal items: %@", [dict valueForKey:@"itemsArray"]);
    return pack;
    
}

//Create items array
-(NSMutableArray *) createItems: (NSMutableArray *) mArray;
{
    NSLog(@"items Array: %@", mArray);
    
    NSMutableArray *packArray = [NSMutableArray new];
    for (NSDictionary *dict in mArray) {
        NSLog(@"item One: %@,", [dict valueForKey:@"Congratulations"]);
        
        MeditationItem *item = [MeditationItem new];
        
        item.meditaitonItemTitle = [dict valueForKey:@"Title"];
        item.meditationItemDescriptionText = [dict valueForKey:@"Description"];
        item.meditaitonItemAudioClip = [dict valueForKey:@"Song"];
        item.meditationItemCongratulationsText = [dict valueForKey:@"Congratulations"];
        [packArray addObject:item];
    }
    
    return packArray;
}

-(MeditationPack *) createMeditationPack;
{
    
    MeditationPack *pack = [[MeditationPack alloc] init];
    pack.meditationPackID = 0;
    pack.meditationPackTitle = _medPackTitle;
    pack.meditiationPackImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[_storeImageData objectAtIndex:0]]];
    pack.meditationItemsArray = _meditationItemArray;
    
    //Save Data For persistent use
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    
    NSMutableArray *savedPacksArray = [NSMutableArray new];
    
    if ( [userDefault objectForKey:@"Meditation Packs"] != nil)
    {
        NSLog(@"SAVED UD = %@", [userDefault objectForKey:@"Meditation Packs"]);
        NSArray *savedPackArr = [userDefault objectForKey:@"Meditation Packs"];
        [savedPacksArray addObjectsFromArray:savedPackArr];
    }
    
    
    NSLog(@"SAVED PACKS ARRAY 1 = %@", savedPacksArray);
    
    NSString *savedImage = [NSString stringWithFormat:@"%@",[_storeImageData objectAtIndex:0]];
    BOOL packDownloaded = YES;

    NSDictionary *packDict = @{@"Title":_medPackTitle,
                               @"Image":savedImage,
                               @"hasDownloaded":[NSString stringWithFormat:@"%i",packDownloaded],
                               @"itemsArray": _savedItem
                               };
    
    [savedPacksArray addObject:packDict];
    
    
    NSLog(@"SAVED PACKS ARRAY 2 = %@", savedPacksArray);
    NSLog(@"PACKS ARRAY 1= %@", savedPacksArray);

    [userDefault setObject:savedPacksArray forKey:@"Meditation Packs"];
    [userDefault synchronize];
    
    NSLog(@"SAVED UD = %@", [userDefault objectForKey:@"Meditation Packs"]);

    return pack;
}

-(MeditationItem*)createMeditationItemFromDict:(NSDictionary*)dict withSong:(NSString*)song
{
    MeditationItem *item = [[MeditationItem alloc] init];
    
    item.meditaitonItemTitle = [NSString stringWithFormat:@"%@", [dict valueForKey:@"Title"]];
    item.meditaitonItemAudioClip = song;
    item.meditationItemDescriptionText = [NSString stringWithFormat:@"%@", [dict valueForKey:@"Description"]];
    item.meditationItemCongratulationsText = [NSString stringWithFormat:@"%@", [dict valueForKey:@"Congratulations"]];
    
    return item;
    
}

-(void)stepThroughEachItem
{
    if (!_meditationItemArray)
    {
        _meditationItemArray = [[NSMutableArray alloc] init];
        
    }
    
    NSMutableArray *udArr = [NSMutableArray new];
    
    int i = 0;
    for (id obj in _storeData)
    {
        //Stored Data persisted
        NSMutableDictionary *pListDict = [[NSMutableDictionary alloc] initWithContentsOfFile:obj];
        [pListDict setValue:[NSString stringWithFormat:@"%@", [_storeSongData objectAtIndex:i]] forKey:@"Song"];
        [udArr addObject:pListDict]; // Info that will be stored in userdefaults

        [_meditationItemArray addObject:[self createMeditationItemFromDict:pListDict
                                                                  withSong:[NSString stringWithFormat:@"%@", [_storeSongData objectAtIndex:i]]]];
        i++;
    }
    
    // Given `items` contains an array of items objects
    NSArray *ud = [[NSArray alloc]initWithArray:udArr];
    _savedItem = [[NSMutableArray alloc] initWithArray:ud];
    
    return;
  
   }


@end
