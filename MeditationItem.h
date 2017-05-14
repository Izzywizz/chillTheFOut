//
//  MeditationItem.h
//  DataModelChill
//
//  Created by Izzy on 10/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//
/*
 The Meditation Item class cretes an instance of Meditation item, these are then included within the Medtitation Packs by adding them into the array referenced within that class.
 */
#import <Foundation/Foundation.h>

@interface MeditationItem : NSObject

@property (nonatomic) NSString *meditaitonItemTitle;
@property (nonatomic) NSString *meditaitonItemAudioClip;
@property (nonatomic) NSString *meditationItemDescriptionText;
@property (nonatomic) NSString *meditationItemCongratulationsText;
@property (nonatomic) int meditationItemID;

@end
