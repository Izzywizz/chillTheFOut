//
//  ViewController.m
//  DataModelChill
//
//  Created by Izzy on 10/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//

/*
 This the main screen of the app, it handles the view and selction of the individual Mediation Packs
 The data is accessed from the singleton data class which allows the creation of views dynamically.
 So for example, depending on what row the user selects on the indexpath.row this then corresponds to the actual Switch Case within the switch element of the data class, this means that
 when the user hits for example 0 (which is today medtiaton) then that becomes the selected object to which we build the next view upon, this is stored with SelectedMeditaionPack
 Singleton allows all of this because there is only one instance within the app thus the data remains consistent.
 */

#import "ViewController.h"
#import "Data.h"
#import "MeditationItemDataSource.h"
#import "MeditationPackDataSource.h"
#import "MeditationItem.h"
#import "MeditationPack.h"
#import "MeditationItemViewController.h"

//Handling cell creation
// Rows - datarray count

// cell for row at index path
// MedicationPack *p = [_data objectAtIndexPath:indexpath.row];
// cell.title.text = p.title;

// Did select cell at ind path
//  initiate the detail tableview controller
// MedicationPack *p = [_data objectAtIndexPath:indexpath.row]
// set the data arrat for the next view as p.meditationitemsarray.

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *InfoButton;
@property NSMutableArray *dataArray;
@end

BOOL setupComplete;

@implementation ViewController


#pragma mark - UIViewController

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    //[self setupDataArray];
    // [super viewWillAppear:animated];
    _dataArray = [[NSMutableArray alloc]initWithArray:[Data sharedInstance].meditationPackArray];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // start the method that creates and returns the data object, unpacking them for use.
    [[Data sharedInstance] setup];
    //NSLog(@"xxx %@",[Data sharedInstance].meditationPackArray);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Count Items in the Data Shared Instance medicationpackarray to find number of rows
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Create the cell (based on prototype)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    
    //Configure the cell
    MeditationPack *pack = [_dataArray objectAtIndex:indexPath.row];// self.MainMenuDataSet[indexPath.row];
    
    cell.textLabel.text = pack.meditationPackTitle;
    cell.imageView.image = pack.meditiationPackImage;
    
    return cell;

}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [Data sharedInstance].selectedMeditationPack = [_dataArray objectAtIndex:indexPath.row];
    NSLog(@"%ld", (long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //remove the selection animation

    //create the view, institate it
    //view did load/s appear
    // set that data
    
    
    [self performSegueWithIdentifier:@"GoToMeditationItem" sender: self];

}


#pragma mark - DataCheckMethods
-(void)setupDataArray
{
    //_dataArray = [Data sharedInstance].meditationPackArray;
    
    for (MeditationPack *pack in [Data sharedInstance].meditationPackArray)
    {
        
        NSLog(@"NAME = %@", pack.meditationPackTitle);
        NSLog(@"IMAGE = %@", pack.meditiationPackImage);
        
        for (MeditationItem *item in pack.meditationItemsArray)
        {
            NSLog(@"ITEM TITLE = %@", item.meditaitonItemTitle);
            NSLog(@"ITEM DESCRIPTION = %@", item.meditationItemDescriptionText);
            NSLog(@"ITEM AUDIO = %@", item.meditaitonItemAudioClip);
            NSLog(@"ITEM CONGRATULATIONS = %@", item.meditationItemCongratulationsText);
        }
    }
}

#pragma mark - IBAction
- (IBAction)InfoButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"GoToInfo" sender:self];
}

- (IBAction)AddNewMeditationButtonPressed:(id)sender {
    NSLog(@"Add New Meditaiton Button Pressed");
    [self performSegueWithIdentifier:@"GoToAddNewMeditation" sender:self];
}

@end
