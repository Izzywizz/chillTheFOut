//
//  MeditationItemAudio.m
//  DataModelChill
//
//  Created by Izzy on 10/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

// We need to display the custom description from a specific meditation item
// We need to also create a way for the audio to play and pause

//Audio section
// create an instance of the AuidoCreation
// split the audio file into its components
// pass in the audio file to be played
// return the audio object then pass it to the actual audio player

/*
 Audio/ timer methods handles how the audio is returned to user, it gives the user the ability to pause and play, change images based on that selection of pausing etc.
 The title of meditation item played is shown to the user within the notication bar
 The seek bar has been disabled and the audio pausing from the notification screen may cause issues within syncing the but this very unlikely to occur, you have to do it like 60 times.
 */

#import "MeditationItemAudio.h"
#import "Data.h"
#import "MeditationItem.h"
#import "MeditationPack.h"
#import "RRAudioCreation.h"
#import <MediaPlayer/MediaPlayer.h>


@interface MeditationItemAudio()<AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *MeditationItemDescription;
@property (weak, nonatomic) IBOutlet UIButton *PlayPauseButton;
@property (weak, nonatomic) IBOutlet UILabel *Timer;


@property BOOL isPlaying;
@property (nonatomic) MeditationItem *item;
@property (nonatomic) RRAudioCreation *audio;
@property (nonatomic) AVAudioPlayer *player;
@property (nonatomic) NSTimer *myTimer;

@end

@implementation MeditationItemAudio

#pragma mark - UIViewController

-(void) viewWillAppear:(BOOL)animated
{
    [self setup];
    [self setNavigationItemTitle];
}

-(void) viewDidDisappear:(BOOL)animated
{
    _player.delegate = nil;// deregistering the delegate!
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self stopTimer];
}


-(void)setNavigationItemTitle
{
    self.navigationItem.title = _item.meditaitonItemTitle;
}

#pragma mark - AudioAndDescriptionSetup

-(void) setup
{
    _item = [Data sharedInstance].selectedMeditationItem;
    _audio = [[RRAudioCreation alloc] init];
    [self setMeditationItemDescription];
    [self audioSetup];
}

-(void) audioSetup
{
    NSLog(@"AudioFile: %@", _item.meditaitonItemAudioClip);

    _player = [_audio prepareFile:_item.meditaitonItemAudioClip];

    _player.delegate = self;
    [self timerSetup];
    [self remoteControlSetup];
}

-(void) remoteControlSetup
{
    NSDictionary *info = @{ MPMediaItemPropertyTitle: _item.meditaitonItemTitle,
                            };
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = info;

}

-(void)setMeditationItemDescription
{
    [_MeditationItemDescription setSelectable:NO]; //prevents selection of the text
    _MeditationItemDescription.text = _item.meditationItemDescriptionText;
}

#pragma mark - IBAction

- (IBAction)playPauseButtonPressed:(id)sender {
    if (!_isPlaying)
    {
        [self playAudio];
        
    } else if (_isPlaying)
    {
        [self pauseAudio];
    }
}

- (IBAction)BackButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];//Return to the previous controller!
    [self stopTimer];
    [self pauseAudio];
}

#pragma mark - UIAVAudioDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (flag) {
        NSLog(@"Song finished");
        _isPlaying = NO;
        [_PlayPauseButton setImage:[UIImage imageNamed:@"play-button-icon.png"] forState:UIControlStateNormal];
        [self performSegueWithIdentifier:@"GoToMeditationEnd" sender:self];
    }
}

#pragma mark - AudioMethods

//Make sure we can recieve remote control events

-(void) playAudio
{
    NSLog(@"Play");
    [_PlayPauseButton setImage:[UIImage imageNamed:@"pause-button-icon.png"] forState:UIControlStateNormal];
    [_player play];
    [self callTimer]; //starts the timer!
    _isPlaying = YES;

}

-(void) pauseAudio
{
    NSLog(@"Pause");
    [_PlayPauseButton setImage:[UIImage imageNamed:@"play-button-icon.png"] forState:UIControlStateNormal];
    [_player pause];
    _isPlaying = NO;

}

- (void)togglePlayPause {
    //Toggle if the music is playing or paused
    if (!self.player.playing) {
        [self playAudio];
        
    } else if (self.player.playing) {
        [self pauseAudio];
        
    }
}

#pragma mark - RemoteControl
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent {


    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"prev");
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"next");
                break;
                
            case UIEventSubtypeRemoteControlPlay:
                [self playAudio];
                break;
                
            case UIEventSubtypeRemoteControlPause:
                [self pauseAudio];
                break;
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [self togglePlayPause];
                break;
                
            default:
                break;
        }
    }
}


#pragma mark - TimerMethods


-(void)timerSetup
{
    //Grab the full/ duration of the song
    //Display it to the TimerLabel
    NSTimeInterval timeLeft = [_player duration];
    NSLog(@"%f", timeLeft);
    int min = [self calculateMinutes:timeLeft];
    int sec = [self calcualteSeconds:timeLeft];
    _Timer.text = [NSString stringWithFormat:@"%02d : %02d ", min,sec];
}

- (void)updateTimeLeft
{
    //obtain the current time - duration which gives you the total time left, this method is called every second thanks to NSTimer
    NSTimeInterval timeLeft = self.player.duration - self.player.currentTime;
    int min =[self calculateMinutes:timeLeft];
    int sec = [self calcualteSeconds:timeLeft];
    // update your UI with timeLeft
    _Timer.text = [NSString stringWithFormat:@"%02d : %02d ", min,sec];
}

-(void) callTimer
{
     _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                         target:self
                                                       selector:@selector(updateTimeLeft)
                                                       userInfo:nil
                                                        repeats:YES];
}

-(void) stopTimer
{
    [_myTimer invalidate]; //Stops the timer from firing and thus prevents the music from continualy playing after the back button is pressed.
    _myTimer = nil;
}


-(int) calculateMinutes:(NSTimeInterval)time
{
    int min = time / 60; //per second
    return min;
}

-(int) calcualteSeconds:(NSTimeInterval)time
{
    int sec = lroundf(time) % 60; //per second!
    return sec;
}



@end
