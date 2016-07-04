//
//  VideoCreation.m
//  DataModelChill
//
//  Created by Izzy on 14/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

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
