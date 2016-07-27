//
//  IAPHelper.m
//  Chill The F Out
//
//  Created by Izzy on 29/06/2016.
//  Copyright © 2016 Izzy. All rights reserved.
//
/*
 
 Process the files downloaded from the  Apple server, splitting them based on the path extentions
 There is a limitation on the file processing in that the files have to be in alphabetic order, for example:
 Item 1:
 sad.mp3
 sad.plist
 
 Item 2:
 happy.mp3
 happy.plist
 
 So the happy song/ plist (Item2) would be done first then Item1
 The title for Pack needs to be set within the ContentsInfo.plist
 The dictionary key values set within the actual indivudal item plist must be correct or they wont match.
 
 Future update: There is only one image present at the momnent so retina phones wont look great
 
 */

#import "IAPHelper.h"


@interface IAPHelper()

@property (nonatomic) NetworkData *store;
@property (nonatomic) NSFileManager *filemanager;

@end


@implementation IAPHelper

#pragma mark - dataDownloadedFromStoreMethods

- (void) processDownload:(SKDownload*)download
{
    _store = [[NetworkData alloc] init];
    _filemanager = [NSFileManager defaultManager];
    
    // files are in Contents directory
    NSString *path = [download.contentURL path];
    path = [path stringByAppendingPathComponent:@"Contents"];
    
    //int NumberOfPacks = [self NumberOfPacks:download];
    //int numberOfFiles = [self numberOfFiles:download];
    
    //Grab the title from contentInfo plist
    NSString *title = [self packTitle:download];
    
    //find all the files in the directory and store it in an array
    NSArray *fileList = [_filemanager contentsOfDirectoryAtPath:path error:nil];
    
    NSLog(@"File Path: %@", fileList);
    //iterate through the array and add the full path source to the file
    
    
    for (NSString *file in fileList) {
        
        //Only one Image associated with a pack! And The title
        if ([[file pathExtension] isEqualToString:@"png"])
        {
            NSString *fullPathSrcPng = [path stringByAppendingPathComponent:file];
            [_store storeImagePath:fullPathSrcPng];
            _store.medPackTitle = title;//set the title of the pack!
            NSLog(@"ContentID: %@",download.contentIdentifier);
        }
        //If the song mp3 file is equal to the plist name then add it to the storeData
        else if ([[file pathExtension] isEqualToString:@"mp3"])
        {
            
            NSString *fullPathSrcForMp3 = [path stringByAppendingPathComponent:file];
            [_store storeMp3Path:fullPathSrcForMp3];
        }
        else if ([[file pathExtension] isEqualToString:@"plist"])
        {
            NSString *fullPathPlist = [path stringByAppendingPathComponent:file];
            [_store storeDataViaPlist:fullPathPlist];
        }
    }
    
    [_store stepThroughEachItem];
    [self createDownloadedPack];
}

#pragma mark - CreateMeditationObjectMethod

-(void) createDownloadedPack
{
    MeditationPack *pack6 = [[MeditationPack alloc] init];
    pack6 = [_store createMeditationPack];
    [[Data sharedInstance].meditationPackArray addObject:pack6];
}

//Methods that obtain the number of items to be created etc, these are stored a level above in contents list, contents list > "Acutal files"
-(int)NumberOfPacks: (SKDownload *)download
{
    NSString *source = [download.contentURL relativePath];
    NSDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:[source stringByAppendingPathComponent:@"ContentInfo.plist"]];
    int NumberOfPacks = [[dict objectForKey:@"NumberOfPacks"] intValue];
    
    return NumberOfPacks;
}

-(int) numberOfFiles: (SKDownload *) download
{
    NSString *source = [download.contentURL relativePath];
    NSDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:[source stringByAppendingPathComponent:@"ContentInfo.plist"]];
    int numberOfFiles = [[dict valueForKey:@"NumberOfFiles"] intValue];
    
    return numberOfFiles;
}

-(NSString *) packTitle: (SKDownload *) download
{
    NSString *source = [download.contentURL relativePath];
    NSDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:[source stringByAppendingPathComponent:@"ContentInfo.plist"]];
    NSString *title = [dict valueForKey:@"MeditationPackTitle"];
    
    return title;
}

@end
