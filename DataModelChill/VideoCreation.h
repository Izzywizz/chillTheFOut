//
//  VideoCreation.h
//  DataModelChill
//
//  Created by Izzy on 14/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface VideoCreation : NSObject

@property (nonatomic) AVPlayer *player;

-(AVPlayer *) setupVideoFileTitle:(NSString *)title andFileType:(NSString *)type;

@end
