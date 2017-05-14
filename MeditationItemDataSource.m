//
//  MeditationItemDataSource.m
//  DataModelChill
//
//  Created by Izzy on 10/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "MeditationItemDataSource.h"
#import "MeditationItem.h"

@implementation MeditationItemDataSource

-(NSMutableArray *)meditationItemArray:(int)packID
{
    
    NSMutableArray *packArray = [NSMutableArray new];
    
    
    int totalPacks = (int)[[self meditationTitleArray:packID]count];
    NSLog(@"totalPack: %d", totalPacks);
    for (int i = 0; i < totalPacks; i++)
    {
            MeditationItem *item = [MeditationItem new];
            
            item.meditaitonItemTitle = [NSString stringWithFormat:@"%@", [[self meditationTitleArray:packID] objectAtIndex:i]];
            item.meditationItemDescriptionText = [NSString stringWithFormat:@"%@", [[self meditationDescriptionArray:packID] objectAtIndex:i]];
            item.meditationItemCongratulationsText = [NSString stringWithFormat:@"%@", [[self meditationCongratulationsArray:packID] objectAtIndex:i]];
            item.meditaitonItemAudioClip = [NSString stringWithFormat:@"%@", [[self meditationAudioArray:packID] objectAtIndex:i]];
            [packArray addObject:item];
        
        NSLog(@"pack %@",packArray);

    }
    
    return packArray;
}


-(NSArray *)meditationTitleArray:(int)packID
{
    switch (packID) {
        case 0:
            return @[@"Get Motivated", @"Increase your energy", @"Improve your mood"];
            break;
        case 1:
            return @[@"Get Motivated", @"Increase your energy", @"Improve your mood"];
            break;
        case 2:
            return @[@"Get Motivated", @"Increase your energy", @"Improve your mood"];
            break;
        case 3:
            return @[@"Get Motivated", @"Increase your energy", @"Improve your mood"];
            break;
        case 4:
            return @[@"Get Motivated", @"Increase your energy", @"Improve your mood"];
            break;
        default:
            break;
            
    }
    return nil;
}
-(NSArray *)meditationDescriptionArray:(int)packID
{
    switch (packID) {
        case 0:
            return @[@"Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning",
                     @"Test2 Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning",
                     @"Test3 Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning"];
            break;
        case 1:
            return @[@"Test4: Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning",
                     @"Test5: Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning",
                     @"Test6: Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning"];
            break;
        case 2:
            return @[@"Test7: Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning",
                     @"Test8: Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning",
                     @"Test9: Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning"];
            break;
        case 3:
            return @[@"Test10: Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning",
                     @"Test11: Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning",
                     @"Test12: Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning"];
            break;
        case 4:
            return @[@"Test13: Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning",
                     @"Test14: Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning",
                     @"Test15: Are you struggling to get motivated this morning? If the answer is yes then this is the perfect meditations for you. In 20 mins time you’ll be raring to go with all the enthuasiasm of a child on Christmas morning"];
            break;
        default:
            break;
            
    }
    return nil;
}

//create method for the audio clip
-(NSArray *)meditationAudioArray:(int)packID
{
    switch (packID) {
        case 0:
            return @[@"test1.mp3", @"test2.mp3", @"test3.mp3"];
            break;
        case 1:
            return @[@"test3.mp3", @"test2.mp3", @"test1.mp3"];
            break;
        case 2:
            return @[@"test2.mp3", @"test2.mp3", @"test1.mp3"];
            break;
        case 3:
            return @[@"test3.mp3", @"test2.mp3", @"test1.mp3"];
            break;
        case 4:
            return @[@"test1.mp3", @"test2.mp3", @"test3.mp3"];
            break;
        default:
            break;
            
    }
    return nil;
}

-(NSArray *)meditationCongratulationsArray:(int)packID
{
    switch (packID) {
        case 0:
            return @[@"Congratulations you’re now ready to take on the world! ",
                     @"Test2: Congratulations you’re now ready to take on the world!",
                     @"Congratulations you’re now ready to take on the world!"];
            break;
        case 1:
            return @[@"Test4: Congratulations you’re now ready to take on the world!",
                     @"Test5: Congratulations you’re now ready to take on the world!",
                     @"Test6: Congratulations you’re now ready to take on the world!"];
            break;
        case 2:
            return @[@"Test7: Congratulations you’re now ready to take on the world!",
                     @"Test8: Congratulations you’re now ready to take on the world!" ,
                     @"Test9: Congratulations you’re now ready to take on the world!"];
            break;
        case 3:
            return @[@"Test10: Congratulations you’re now ready to take on the world!",
                     @"Test11: Congratulations you’re now ready to take on the world!" ,
                     @"Test12: Congratulations you’re now ready to take on the world!"];
            break;
        case 4:
            return @[@"Test14: Congratulations you’re now ready to take on the world!",
                     @"Test15: Congratulations you’re now ready to take on the world!",
                     @"Test16: Congratulations you’re now ready to take on the world!"];
            break;
        default:
            break;
            
    }
    return nil;
}

@end
