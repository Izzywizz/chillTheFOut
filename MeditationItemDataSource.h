//
//  MeditationItemDataSource.h
//  DataModelChill
//
//  Created by Izzy on 10/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MeditationItem;

@interface MeditationItemDataSource : NSObject

-(NSMutableArray *)meditationItemArray:(int)packID;

@end
