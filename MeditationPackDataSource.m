//
//  MeditationPackDataSource.m
//  DataModelChill
//
//  Created by Izzy on 10/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "MeditationPackDataSource.h"
#import "MeditationItemDataSource.h"
#import "MeditationItem.h"
#import "MeditationPack.h"
#import "NetworkData.h"


@implementation MeditationPackDataSource


-(NSArray *)meditationPackArray
{
    
    NSMutableArray *medPackArray = [NSMutableArray new];
    
    //Load Item Data
    NSLog(@"SAVED MED PACKS UD = %@", [[NSUserDefaults standardUserDefaults]objectForKey:@"Meditation Packs"]);
    NSArray *savedMedPack = [[NSUserDefaults standardUserDefaults]objectForKey:@"Meditation Packs"];
    
    
    for (int i = 0; i <  [[self meditationPackTitleArray] count]; i++)
    {
        MeditationPack *meditationPack = [MeditationPack new];
        meditationPack.meditationPackTitle = [NSString stringWithFormat:@"%@", [[self meditationPackTitleArray] objectAtIndex:i]];
        meditationPack.meditiationPackImage = [UIImage imageNamed: [[self meditationPackImageArray] objectAtIndex:i]];
        meditationPack.meditationItemsArray = [[self meditationItemsArray:i] mutableCopy];
        NSLog(@"item: %@", medPackArray);
        [medPackArray addObject:meditationPack];
    }
    
    //Saved Packs/ Downloaded from the tinternet!
    
    for (NSDictionary *dictionary in savedMedPack) {
        
        //NSLog(@"Dictionary %i: %@", i, dictionary);
        
        NetworkData *data = [[NetworkData alloc] init];
        
        //NSLog(@"%i %@", i, [data createMeditationPack:dictionary]);
        
        MeditationPack *downloadedPack = [MeditationPack alloc];
        downloadedPack = [data createMeditationPack:dictionary];
        //NSLog(@"downloadedPack: %@", downloadedPack);

        [medPackArray addObject:downloadedPack];
        
    }
    NSLog(@"MedPack ARRay: %@", medPackArray);
    
    return medPackArray;
}


#pragma mark - defaultPacks

-(NSArray *)meditationPackTitleArray
{
    
    return @[@"Today's Meditation", @"Morning Meditiation", @"Nighttime Meditation", @"Going To Sleep", @"Walking"];
}

-(NSArray *)meditationPackImageArray
{
    
    return @[@"calender-icon-cell.png", @"morning-meditation-cell.png", @"nighttime-icon-cell.png", @"sleep-icon-cell.png", @"walking-icon-cell.png"];
}


-(NSArray *)meditationItemsArray:(int)packID
{
    MeditationItemDataSource *mpdc = [[MeditationItemDataSource alloc] init];
    
    return [mpdc meditationItemArray:packID];
    
}

@end
