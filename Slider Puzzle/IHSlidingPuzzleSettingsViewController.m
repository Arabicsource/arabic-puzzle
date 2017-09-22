//
//  IHSlidingPuzzleSettingsViewController.m
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/9/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import "IHSlidingPuzzleSettingsViewController.h"
#import "IHDataModel.h"
#import "MessageViewController.h"

@implementation IHSlidingPuzzleSettingsViewController
@synthesize topBar, settingItems, segmentedControl;
@synthesize difficultyLevelLbl, versionLbl, developerLbl, ownerLbl, showNumbersLbl, switchNumbers;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    if(topBar!= nil)
        IH_RELEASE_SAFELY(topBar);
    if(segmentedControl!= nil)
        IH_RELEASE_SAFELY(segmentedControl);
    if(settingItems!= nil)
        IH_RELEASE_SAFELY(settingItems);
    if(difficultyLevelLbl!= nil)
        IH_RELEASE_SAFELY(difficultyLevelLbl);
    if(versionLbl!= nil)
        IH_RELEASE_SAFELY(versionLbl);
    if(developerLbl!= nil)
        IH_RELEASE_SAFELY(developerLbl);
    if(ownerLbl!= nil)
        IH_RELEASE_SAFELY(ownerLbl);
    if(showNumbersLbl!= nil)
        IH_RELEASE_SAFELY(showNumbersLbl);
    if(switchNumbers!= nil)
        IH_RELEASE_SAFELY(switchNumbers);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Customize the number of rows in the table view.
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [settingItems count];
}

// Customize the appearance of table view cells.
///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell.
    cell.textLabel.text = [settingItems 
                           objectAtIndex: [indexPath row]];    
    return cell;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch ([indexPath row]) {
        case WRITE_REVIEW_TYPE:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAppReviewUrl]];
            break;
        case TEEL_FRIEND_TYPE:
        {
            MessageViewController *msgVC = [[[MessageViewController alloc] init] autorelease];
            [msgVC.navigationBar setTintColor:[UIColor darkGrayColor]];  
           [self presentModalViewController:msgVC animated:YES];
        }    
            break;
        case ABOUT_APP_TYPE:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAppMoreInfoUrl]];
            break;
        case ABOUT_DEV_TYPE:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAppDevelopperUrl]];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
}

///////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    topBar.topItem.title = IH_STRING(@"Settings");
    difficultyLevelLbl.text =  IH_STRING(@"Difficulty level");
    versionLbl.text =  [NSString stringWithFormat:@"%@ v%@", kAppName, kAppVersion];
    developerLbl.text =  [NSString stringWithFormat:IH_STRING(@"Created by"),kAppDevelopper];
    ownerLbl.text =  [NSString stringWithFormat:IH_STRING(@"Copyright"),kAppOwner];
    showNumbersLbl.text =  IH_STRING(@"Show numbers");
    
    settingItems = [[NSArray alloc] 
                       initWithObjects:IH_STRING(@"Write a review"), IH_STRING(@"Tell a friend"), [NSString stringWithFormat:IH_STRING(@"About app"),kAppName],
                       IH_STRING(@"About developer"), nil];
    
    NSInteger pieciesMode = [[[IHDataModel model].settings objectForKey:kPieciesMode] intValue];
    if (nil != segmentedControl) {
        segmentedControl.selectedSegmentIndex = pieciesMode;
        [segmentedControl setTintColor:[UIColor darkGrayColor]];
    } 
    
    if(nil != switchNumbers){
        switchNumbers.on = [IHDataModel model].showNumnerOnTiles;
        //[switchNumbers setOnTintColor:[UIColor darkGrayColor]];
    }
}

///////////////////////////////////////////////////////////////////////////////////////
-(IBAction) segmentedControlIndexChanged{
    NSNumber *number = [NSNumber numberWithInt:0];
    switch (segmentedControl.selectedSegmentIndex) {
		case PIECE_3_3:
            number = [NSNumber numberWithInt:0];
			break;
		case PIECE_4_4:
            number = [NSNumber numberWithInt:1];
			break;
        case PIECE_5_5:
            number = [NSNumber numberWithInt:2];
			break;
		default:
            break;
    }
    
    [IHDataModel model].pieciesMode = number;
    [[NSNotificationCenter defaultCenter] postNotificationName:kPuzzleChangedNotification object:nil];
}

///////////////////////////////////////////////////////////////////////////////////////
- (IBAction)switchNumbersChanged:(id)sender{
    [IHDataModel model].showNumnerOnTiles = switchNumbers.on;
    [[NSNotificationCenter defaultCenter] postNotificationName:kPuzzlePropertiesChangedNotification object:nil];
}

///////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload
{
    [super viewDidUnload];
}

///////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)done:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
