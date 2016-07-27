//
//  IzzyMusic.h
//  Chill The F Out
//
//  Created by Isfandyar Ali on 05/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RRAudioCreation : NSObject

@property (nonatomic) AVAudioPlayer *player;
@property (nonatomic) NSString *audioFileTitle;
@property (nonatomic) NSString *audioFileType;

#pragma mark - Audio Creation
/**
 Creates, prepares returns an initialised AVAudioPlayer object to be used al so registered it with the iOS RemoteControl events
 Bool (true) - if the audio file is downloaded from external source using NSURL
 Bool (false) - audio file is part of the main bundle
 */
-(AVAudioPlayer *)audioFile :(NSString *)pathForResource fileType:(NSString *)fileType doesHaveURL:(BOOL) url;

#pragma mark - Audio File Preparation
/**
 Able to split down file of a downloaded audile file to its components (filename and file extension).
 it determines whether it is NSURL or part of the main bundle then internally calls the audio creation method to return
 a ready to use AVAudioPlayer object
 */
-(AVAudioPlayer *)prepareFile: (NSString *)fullComponentsOfFile;


@end
