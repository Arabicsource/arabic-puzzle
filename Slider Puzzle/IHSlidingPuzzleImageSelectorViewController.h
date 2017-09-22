//
//  IHSlidingPuzzleImageSelectorViewController.h
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IHSlidingPuzzleImageSelectorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    IBOutlet UINavigationBar *topBar;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *topBar;

- (IBAction)done:(id)sender;

@end
