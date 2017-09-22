//
//  IHSlidingPuzzleSettingsViewController.h
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/9/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import <UIKit/UIKit.h>

// Define the settings
typedef enum {
	WRITE_REVIEW_TYPE	= 0,
	TEEL_FRIEND_TYPE    = 1,
    ABOUT_APP_TYPE      = 2,
    ABOUT_DEV_TYPE      = 3
} SettingType;

@interface IHSlidingPuzzleSettingsViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UINavigationBar *topBar;
    IBOutlet UISegmentedControl *segmentedControl;
    NSArray *settingItems;
    
    IBOutlet UILabel *difficultyLevelLbl;
    IBOutlet UILabel *versionLbl;
    IBOutlet UILabel *developerLbl;
    IBOutlet UILabel *ownerLbl;
    IBOutlet UILabel *showNumbersLbl;
    IBOutlet UISwitch *switchNumbers;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *topBar;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, retain) NSArray *settingItems;

@property (nonatomic, retain) IBOutlet UILabel *difficultyLevelLbl;
@property (nonatomic, retain) IBOutlet UILabel *versionLbl;
@property (nonatomic, retain) IBOutlet UILabel *developerLbl;
@property (nonatomic, retain) IBOutlet UILabel *ownerLbl;
@property (nonatomic, retain) IBOutlet UILabel *showNumbersLbl;
@property (nonatomic, retain) IBOutlet UISwitch *switchNumbers;

- (IBAction)done:(id)sender;
- (IBAction)segmentedControlIndexChanged;
- (IBAction)switchNumbersChanged:(id)sender;

@end
