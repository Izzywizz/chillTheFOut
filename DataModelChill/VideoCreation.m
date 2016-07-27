//
//  VideoCreation.m
//  DataModelChill
//
//  Created by Izzy on 14/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//
/*
 Handles the video elements of the app, returns a fully ready to go videoPlayer object that is used within the Help table view.
 */

#import "VideoCreation.h"

@implementation VideoCreation

#pragma mark - AVPlayer

-(AVPlayer *) setupVideoFileTitle:(NSString *)title andFileType:(NSString *)type
{
    NSString *thePath = [[NSBundle mainBundle] pathForResource:title ofType:type];
    NSURL *theurl = [NSURL fileURLWithPath:thePath];
    _player = [AVPlayer playerWithURL:theurl];
    
    return _player;
}

@end
