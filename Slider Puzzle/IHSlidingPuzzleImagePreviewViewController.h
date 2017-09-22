//
//  IHSlidingPuzzleImagePreviewViewController.h
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IHSlidingPuzzleImagePreviewViewController : UIViewController{
    
    IBOutlet UINavigationBar *topBar;
    IBOutlet UIImageView *imageView;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *topBar;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

- (IBAction)done:(id)sender;
@end
