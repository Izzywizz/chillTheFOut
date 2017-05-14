//
//  HelpTableViewController.m
//  DataModelChill
//
//  Created by Izzy on 14/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

/*
 * When the user selects either menu option, a video is shown to the user.
 * they are able to return to the help menu
 * maybe abstrct the video functionality
 */


#import "HelpTableViewController.h"
#import "VideoCreation.h"

@interface HelpTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSString *thePath;
@property (nonatomic) AVPlayer *player;
@property (nonatomic) VideoCreation *videoCreation;

@end

@implementation HelpTableViewController


#pragma mark - UITableView

-(void)viewWillAppear:(BOOL)animated
{
     _videoCreation = [VideoCreation new];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //remove the selection animation
    switch (indexPath.row) {
        case 0:
            _player = [_videoCreation setupVideoFileTitle:@"test" andFileType:@"mp4"];
            [self playVideo];
            break;
        case 1:
            _player = [_videoCreation setupVideoFileTitle:@"test2" andFileType:@"mp4"];
            [self playVideo];
            break;
        default:
            break;
    }
}

#pragma mark - TableViewDelegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] ;
    return headerView;
}


#pragma mark - Video

-(void) playVideo
{
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    playerViewController.player = _player;
    [playerViewController.player play];//Used to Play On start
    [self presentViewController:playerViewController animated:YES completion:nil];//Present video modally

}

@end
