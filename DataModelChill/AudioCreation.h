//
//  IzzyMusic.h
//  Chill The F Out
//
//  Created by Isfandyar Ali on 05/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioCreation : NSObject

@property (nonatomic) AVAudioPlayer *player;
@property (nonatomic) NSString *audioFileTitle;
@property (nonatomic) NSString *audioFileType;


-(AVAudioPlayer *)audioFile :(NSString *)pathForResource fileType:(NSString *)fileType doesHaveURL:(BOOL) url;
-(AVAudioPlayer *)prepareFile: (NSString *)fullComponentsOfFile;


@end
