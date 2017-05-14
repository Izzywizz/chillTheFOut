//
//  MeditationItemViewController.m
//  DataModelChill
//
//  Created by Izzy on 13/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

/*
 Handles the Meditation Item views, these are built using the previous reference to the meditation pack, the selectedMeditationPack.
 So we access the specific object(Meditation Pack) we are looking at and the mediationItem array attached to that specfically selected object.
 These are then stored within a persistent (within the Data / singleton class) selectedMeditaionItem object meaning that the reference to it can be kept 
 It all works based on what selection the user makes on the table row and thatthen corresponds to what the Switch case is selected within the Data class
 */

#import "MeditationItemViewController.h"
#import "Data.h"
#import "MeditationItem.h"
#import "MeditationPack.h"

@interface MeditationItemViewController()<UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *dataArray;
@property MeditationPack *pack;

@end

@implementation MeditationItemViewController


#pragma mark - UIViewController

-(void)viewWillAppear:(BOOL)animated
{
    _dataArray = [NSMutableArray arrayWithArray:[Data sharedInstance].selectedMeditationPack.meditationItemsArray];
    _pack = [Data sharedInstance].selectedMeditationPack;
    [self setNavigationItemTitle];
    
}

-(void)setNavigationItemTitle
{
    self.navigationItem.title = _pack.meditationPackTitle;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] ;
    return headerView;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Create the cell (based on prototype)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    
    //Configure the cell
    MeditationItem *item = [_dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.meditaitonItemTitle;
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //remove the selection animation
    [Data sharedInstance].selectedMeditationItem = [_dataArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"GoToAudio" sender:self];
    
}

#pragma mark - IBAction

- (IBAction)BackButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];//Return to the previous controller!
}

@end
