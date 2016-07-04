//
//  IzzyMusic.m
//  Chill The F Out
//
//  Created by Isfandyar Ali on 05/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import "AudioCreation.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation AudioCreation

#pragma mark - AVAudioPlayer

-(AVAudioPlayer *)audioFile :(NSString *)pathForResource fileType:(NSString *)fileType doesHaveURL:(BOOL) url;
{
    if (url)
    {
        //Downloaded
        NSURL *fileURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@.%@",pathForResource, fileType]];
        NSLog(@"URL: %@", fileURL);
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL
                                                             error:nil];
    }
    else
    {   //Included within App
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: pathForResource
                                                                  ofType: fileType ];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                                       error:nil];
    }

    //self.player.delegate = self;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

    [self.player prepareToPlay];
    
    return self.player;
}

-(AVAudioPlayer *) prepareFile: (NSString *)fullComponentsOfFile
{
    //Spilt the files into its components, file types etc
    NSString *pathNoFileType = [fullComponentsOfFile stringByDeletingPathExtension];
    NSString *fileType = [fullComponentsOfFile pathExtension];
    
    //Check if the file is a URL or path as it will affect the AVSoundPlayer produced.
    if ([[NSFileManager defaultManager] fileExistsAtPath: fullComponentsOfFile])
    {
        NSLog (@"File exists as URL");
        return [self audioFile:pathNoFileType fileType:fileType doesHaveURL:YES];
    }
    else
        NSLog (@"File not found: NOT a URL, must be PATH");
        return [self audioFile:pathNoFileType fileType:fileType doesHaveURL:NO];

}

@end
