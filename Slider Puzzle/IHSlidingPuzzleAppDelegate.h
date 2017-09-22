//
//  SliderPuzzleAppDelegate.h
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IHSlidingPuzzleRootViewController;
@interface IHSlidingPuzzleAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IHSlidingPuzzleRootViewController *rootViewController;

@end
