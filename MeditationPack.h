//
//  MeditationPack.h
//  DataModelChill
//
//  Created by Izzy on 10/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//


/*
 The Meditation Pack class which creates instances of the MeditationPack. There are also a reference to the meditaion items as they are stored as an Array 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MeditationPack : NSObject

@property (nonatomic) NSString *meditationPackTitle;
@property (nonatomic) UIImage *meditiationPackImage;
@property (nonatomic) NSMutableArray *meditationItemsArray;
@property (nonatomic) int meditationPackID;


@end
